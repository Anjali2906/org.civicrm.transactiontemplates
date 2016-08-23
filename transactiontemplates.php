<?php

require_once 'transactiontemplates.civix.php';

/**
 * Implements hook_civicrm_config().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_config
 */
function transactiontemplates_civicrm_config(&$config) {
  _transactiontemplates_civix_civicrm_config($config);
}

/**
 * Implements hook_civicrm_xmlMenu().
 *
 * @param array $files
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_xmlMenu
 */
function transactiontemplates_civicrm_xmlMenu(&$files) {
  _transactiontemplates_civix_civicrm_xmlMenu($files);
}

/**
 * Implements hook_civicrm_install().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_install
 */
function transactiontemplates_civicrm_install() {
  _update_transaction_email_templates();
  _transactiontemplates_civix_civicrm_install();
}

/**
 * Implements hook_civicrm_uninstall().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_uninstall
 */
function transactiontemplates_civicrm_uninstall() {
  _revert_transaction_email_templates();
  _transactiontemplates_civix_civicrm_uninstall();
}

/**
 * Implements hook_civicrm_enable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_enable
 */
function transactiontemplates_civicrm_enable() {
  _update_transaction_email_templates();
  _transactiontemplates_civix_civicrm_enable();
}

/**
 * Implements hook_civicrm_disable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_disable
 */
function transactiontemplates_civicrm_disable() {
  _revert_transaction_email_templates();
  _transactiontemplates_civix_civicrm_disable();
}

/**
 * Implements hook_civicrm_upgrade().
 *
 * @param $op string, the type of operation being performed; 'check' or 'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of pending up upgrade tasks
 *
 * @return mixed
 *   Based on op. for 'check', returns array(boolean) (TRUE if upgrades are pending)
 *                for 'enqueue', returns void
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_upgrade
 */
function transactiontemplates_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _transactiontemplates_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implements hook_civicrm_managed().
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_managed
 */
function transactiontemplates_civicrm_managed(&$entities) {
  _transactiontemplates_civix_civicrm_managed($entities);
}

/**
 * Implements hook_civicrm_caseTypes().
 *
 * Generate a list of case-types.
 *
 * @param array $caseTypes
 *
 * Note: This hook only runs in CiviCRM 4.4+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function transactiontemplates_civicrm_caseTypes(&$caseTypes) {
  _transactiontemplates_civix_civicrm_caseTypes($caseTypes);
}

/**
 * Implements hook_civicrm_angularModules().
 *
 * Generate a list of Angular modules.
 *
 * Note: This hook only runs in CiviCRM 4.5+. It may
 * use features only available in v4.6+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function transactiontemplates_civicrm_angularModules(&$angularModules) {
_transactiontemplates_civix_civicrm_angularModules($angularModules);
}

/**
 * Implements hook_civicrm_alterSettingsFolders().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_alterSettingsFolders
 */
function transactiontemplates_civicrm_alterSettingsFolders(&$metaDataFolders = NULL) {
  _transactiontemplates_civix_civicrm_alterSettingsFolders($metaDataFolders);
}

/**
 * Updates workflow message templates
 *
 *
 */
function _update_transaction_email_templates() {
  $table_name = 'civicrm_msg_template';
  $dir = dirname(__FILE__) . DIRECTORY_SEPARATOR . 'xml/templates';
  $templates = array();
  foreach (preg_grep('/\.tpl$/', scandir($dir)) as $filename) {
    $parts = explode('_', basename($filename, '.tpl'));
    $type = array_pop($parts);
    $name = implode('_', $parts);
    $params = array('name' => $name);
    $defaults = array();
    CRM_Core_BAO_OptionValue::retrieve($params, $defaults);
    $templates[] = array(
      'id' => $defaults['id'],
      'type' => $type,
      'name' => $name,
      'filename' => "$dir/$filename"
    );
  }
  foreach ($templates as $tpl) {
    $params = array('workflow_id'=> $tpl['id']);
    $defaults = array();
    CRM_Core_BAO_MessageTemplate::retrieve($params, $defaults);
    $content = file_get_contents($tpl['filename']);
    $defaults['msg_html'] = $content;
    if ($defaults['id']) {
      CRM_Core_BAO_MessageTemplate::add($defaults);
    }
  }
}

/**
 * Reverts back workflow message templates
 *
 *
 */
function _revert_transaction_email_templates(){
  $table_name = 'civicrm_msg_template';
  $dir = dirname(__FILE__) . DIRECTORY_SEPARATOR . 'xml/templates';
  $templates = array();
  foreach (preg_grep('/\.tpl$/', scandir($dir)) as $filename) {
    $parts = explode('_', basename($filename, '.tpl'));
    $type = array_pop($parts);
    $name = implode('_', $parts);
    $params = array('name' => $name);
    $defaults = array();
    CRM_Core_BAO_OptionValue::retrieve($params, $defaults);
    $templates[] = array(
      'id' => $defaults['id'],
      'type' => $type,
      'name' => $name,
      'filename' => "$dir/$filename"
    );
  }

  foreach ($templates as $tpl) {
    $params = array('workflow_id'=> $tpl['id']);
    $defaults = array();
    CRM_Core_BAO_MessageTemplate::retrieve($params, $defaults);
    if ($defaults['id']) {
      CRM_Core_BAO_MessageTemplate::revert($defaults['id']);
    }
  }
}