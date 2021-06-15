<?php

namespace nnwebPriceOnRequest;

use Doctrine\Common\Collections\ArrayCollection;
use Shopware\Components\Plugin;
use Shopware\Components\Plugin\Context\ActivateContext;
use Shopware\Components\Plugin\Context\DeactivateContext;
use Shopware\Components\Plugin\Context\InstallContext;
use Shopware\Components\Plugin\Context\UninstallContext;
use Shopware\Components\Plugin\Context\UpdateContext;

class nnwebPriceOnRequest extends Plugin {

	public static function getSubscribedEvents() {
		return [
			'Enlight_Controller_Action_PostDispatchSecure_Frontend_Listing' => 'onFrontendPostDispatch', 
			'Enlight_Controller_Action_PostDispatchSecure_Frontend_Detail' => 'onFrontendPostDispatch', 
			'Enlight_Controller_Action_PostDispatchSecure_Frontend_Search' => 'onFrontendPostDispatch', 
			'Enlight_Controller_Action_PostDispatchSecure_Frontend_AjaxSearch' => 'onFrontendPostDispatch', 
			'Enlight_Controller_Action_PostDispatchSecure_Frontend_Forms' => 'onFrontendPostDispatchForms', 
			'Enlight_Controller_Action_PreDispatch_Widgets' => 'onFrontendPostDispatch',
			'Enlight_Controller_Action_PostDispatchSecure_Widgets' => 'onFrontendPostDispatch',
			'Enlight_Controller_Action_PostDispatchSecure_Frontend' => 'addTemplate',
			'Theme_Compiler_Collect_Plugin_Less' => 'addLessFiles' 
		];
	}

	public function activate(ActivateContext $context) {
		$context->scheduleClearCache(InstallContext::CACHE_LIST_FRONTEND);
		parent::activate($context);
	}

	public function deactivate(DeactivateContext $context) {
		$context->scheduleClearCache(InstallContext::CACHE_LIST_FRONTEND);
		parent::deactivate($context);
	}

	public function update(UpdateContext $context) {
		$context->scheduleClearCache(InstallContext::CACHE_LIST_FRONTEND);
		parent::update($context);
	}

	public function install(InstallContext $context) {
		$service = $this->container->get('shopware_attribute.crud_service');
		
		$service->update('s_articles_attributes', 'nnwebPriceOnRequest', 'boolean', [
			'label' => 'Preis auf Anfrage', 
			'supportText' => 'Preis auf Anfrage für diesen Artikel aktivieren.', 
			'helpText' => 'Anstatt des "Warenkorb"-Buttons wird ein "Preis auf Anfrage"-Button angezeigt.', 
			'translatable' => true, 
			'displayInBackend' => true, 
			'position' => 10 
		]);
		$this->deleteCacheAndGenerateModel();
	}

	public function uninstall(UninstallContext $context) {
		$service = $this->container->get('shopware_attribute.crud_service');
		$service->delete('s_articles_attributes', 'nnwebPriceOnRequest');
		$this->deleteCacheAndGenerateModel();
	}
	
	private function deleteCacheAndGenerateModel() {
		$metaDataCache = Shopware()->Models()->getConfiguration()->getMetadataCacheImpl();
		$metaDataCache->deleteAll();
		Shopware()->Models()->generateAttributeModels([
			's_articles_attributes' 
		]);
	}
	
	public function addTemplate(\Enlight_Controller_ActionEventArgs $args) {
		$this->container->get('template')->addTemplateDir($this->getPath() . '/Resources/views/');
	}

	public function addLessFiles(\Enlight_Event_EventArgs $args) {
		$this->container->get('template')->addTemplateDir($this->getPath() . '/Resources/views/');
		$less = new \Shopware\Components\Theme\LessDefinition(array(), array(
			__DIR__ . '/Resources/views/frontend/_public/src/less/all.less' 
		), __DIR__);
		
		return new ArrayCollection(array(
			$less 
		));
	}

	public function onFrontendPostDispatch(\Enlight_Controller_ActionEventArgs $args) {
		$this->container->get('template')->addTemplateDir($this->getPath() . '/Resources/views/');
		$config = $this->container->get('shopware.plugin.cached_config_reader')->getByPluginName($this->getName(), Shopware()->Shop());
		
		$subject = $args->get('subject');
		$view = $subject->View();
		
		$view->assign('nnwebPriceOnRequest_showPrice', $config["nnwebPriceOnRequest_showPrice"]);
		$view->assign('nnwebPriceOnRequest_formularID', $config["nnwebPriceOnRequest_formularID"]);
	}

	public function onFrontendPostDispatchForms(\Enlight_Event_EventArgs $args) {
		$this->container->get('template')->addTemplateDir($this->getPath() . '/Resources/views/');
		$config = $this->container->get('shopware.plugin.cached_config_reader')->getByPluginName($this->getName(), Shopware()->Shop());
		
		$subject = $args->get('subject');
		$request = $args->get('request');
		$view = $subject->View();
		
		$sSupport = $view->getAssign('sSupport');
		if ($sSupport["id"] != $config["nnwebPriceOnRequest_formularID"])
			return;
		
		foreach ($sSupport["sElements"] as $id => &$element) {
			if (strtolower($element['name']) == 'artikelnummer' || strtolower($element['name']) == 'sordernumber') {
				if (!empty($sSupport['sFields'][$id])) {
                    $articleNumbersStr = $request->getParam('bundleArticles', null);
                    if (empty($articleNumbersStr))
				        $articleNumbersStr = $request->getParam('sOrdernumber', null);
					if ($articleNumbersStr !== null) {
                        $articleNumbers = explode(",", $articleNumbersStr);
                        $text = (count($articleNumbers) > 1) ? "Bundle: " : "";
                        foreach ($articleNumbers as $articleNumber) {
						    $getName = Shopware()->Modules()->Articles()->sGetArticleNameByOrderNumber($articleNumber);
						    if ($text != "" && $text != "Bundle: ")
						        $text .= "; ";
						    $text .= $getName . " (" . $articleNumber . ")";
                        }
						$element['value'] = $text;
						$sSupport['sFields'][$id] = $this->_createInputElement($element);
					}
				}
			}
		}

		$view->assign('sSupport', $sSupport);
	}

	protected function _createInputElement($element) {

		if ($element['required'] == 1) {
			$requiredField = 'is--required required';
			$requiredFieldSnippet = '%*%';
			$requiredFieldAria = 'required="required" aria-required="true"';
		} else {
			$requiredField = '';
			$requiredFieldSnippet = '';
			$requiredFieldAria = '';
		}
		
		$placeholder = "placeholder=\"{$element['label']}$requiredFieldSnippet\"";
		
		switch ($element['typ']) {
            case 'hidden':
            case 'text':
			case 'textarea':
				if ($element['typ'] !== 'textarea') {
                    $element['value'] = str_replace('"', '', $element['value']);
				}
				
				break;
			default:
				break;
		}
		
		$output = '';
		switch ($element['typ']) {
            case 'hidden':
            case 'text':
				$output .= "<input type=\"{$element['typ']}\" class=\"{$element['class']} $requiredField\" $requiredFieldAria value=\"{$element['value']}\" id=\"{$element['name']}\" $placeholder name=\"{$element['name']}\"/>\r\n";
				break;
			case 'textarea':
				$output .= "<textarea class=\"{$element['class']} $requiredField\" $requiredFieldAria id=\"{$element['name']}\" $placeholder name=\"{$element['name']}\">{$element['value']}</textarea>\r\n";
				break;
		}
		
		return $output;
	}
}
