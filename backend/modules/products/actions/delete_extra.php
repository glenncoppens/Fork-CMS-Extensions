<?php

/*
 * This file is part of the products module.
 *
 * For the full copyright and license information, please view the license
 * file that was distributed with this source code.
 */

/**
* This delete extra action
 *
 * @author Frederik Heyninck <frederik@figure8.be>
 */
class BackendProductsDeleteExtra extends BackendBaseActionDelete
{
	/**
	 * Execute the action
	 */
	public function execute()
	{
		// get parameters
		$this->id = $this->getParameter('id', 'int');

		// does the item exist
		if($this->id !== null && BackendProductsModel::existsExtra($this->id))
		{
			// call parent, this will probably add some general CSS/JS or other required files
			parent::execute();

			$record = BackendProductsModel::getExtra($this->id);
			$resolutions = BackendProductsModel::getExtraResolutions($this->id);

			// delete item
			BackendProductsModel::deleteExtra($this->id);
			$setsFilesPath = FRONTEND_FILES_PATH . '/' . $this->URL->getModule() . '/sets';

			// Delete resolutions
			foreach($resolutions as $resolution)
			{
				// Does the old resolution exists in the database
				$exists = BackendProductsModel::existsResolution($resolution['width'], $resolution['height'], $resolution['method'] );

				// No
				if(!$exists)
				{
					// Delete old resolutions
					foreach(BackendProductsModel::getAllSets() as $set)
					{
						$to = $setsFilesPath . '/frontend/' . $set['id'] . '/' . $resolution['width'] . 'x' . $resolution['height'] . '_' . $resolution['method'];
						SpoonDirectory::delete($to);

						// Delete cronjob
						if(BackendProductsHelper::existsAmazonS3()) BackendAmazonS3Model::deleteCronjobByFullPath($this->URL->getModule(), $this->URL->getModule() . '/sets/frontend/' . $set['id'] . '/' . $resolution['width'] . 'x' . $resolution['height'] . '_' . $resolution['method']);
					
						$cronjob = array();
						$cronjob['module'] = $this->URL->getModule();
						$cronjob['path'] = $this->URL->getModule() . '/sets/frontend/' . $set['id'] . '/' . $resolution['width'] . 'x' . $resolution['height'] . '_' . $resolution['method'];
						$cronjob['full_path'] = $cronjob['path'] ;
						$cronjob['data'] = serialize(array('set_id' => $set['id'], 'image_id' => null));
						$cronjob['action'] = 'delete';
						$cronjob['location'] = 's3';
						$cronjob['created_on'] =  BackendModel::getUTCDate();
						$cronjob['execute_on'] = BackendModel::getUTCDate();

						if(BackendProductsHelper::existsAmazonS3()) BackendAmazonS3Model::insertCronjob($cronjob);
					}
				}
			}

			// deleted, so redirect
			$this->redirect(BackendModel::createURLForAction('extras') . '&report=deleted-extra');
		}

		// something went wrong
		else $this->redirect(BackendModel::createURLForAction('extras') . '&error=non-existing');
	}

}
