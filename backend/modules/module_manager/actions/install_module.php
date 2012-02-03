<?php

/**
 * This is the module install-action.
 * It will install the module given via the "module" GET parameter.
 *
 * @author Dieter Vanden Eynde <dieter@netlash.com>
 */
class BackendModuleManagerInstallModule extends BackendBaseActionIndex
{
	/**
	 * Module we want to install.
	 *
	 * @var string
	 */
	private $currentModule;

	/**
	 * Execute the action.
	 */
	public function execute()
	{
		// get parameters
		$this->currentModule = $this->getParameter('module', 'string');

		// does the item exist
		if($this->currentModule !== null && BackendExtensionsModel::existsModule($this->currentModule))
		{
			// call parent, this will probably add some general CSS/JS or other required files
			parent::execute();

			// make sure this module can be installed
			$this->validateInstall();
			
			$this->removeOldStuff();

			// do the actual install
			BackendModuleManagerModel::installModule($this->currentModule);

			// redirect to index with a success message
			$this->redirect(BackendModel::createURLForAction('modules') . '&report=module-installed&var=' . $this->currentModule . '&highlight=row-module_' . $this->currentModule);
		}

		// no item found, redirect to index, because somebody is fucking with our url
		else $this->redirect(BackendModel::createURLForAction('modules') . '&error=non-existing');
	}
	
	
	/**
	 * Validate if the module can be installed.
	 */
	private function removeOldStuff()
	{
		BackendModulemanagerModel::delete($this->currentModule);
	}

	/**
	 * Validate if the module can be installed.
	 */
	private function validateInstall()
	{
		// already installed
		if(BackendExtensionsModel::isModuleInstalled($this->currentModule))
		{
			//$this->redirect(BackendModel::createURLForAction('modules') . '&error=already-installed&var=' . $this->currentModule);
		}

		// no installer class present
		if(!SpoonFile::exists(BACKEND_MODULES_PATH . '/' . $this->currentModule . '/installer/installer.php'))
		{
			$this->redirect(BackendModel::createURLForAction('modules') . '&error=no-installer-file&var=' . $this->currentModule);
		}
	}
}
