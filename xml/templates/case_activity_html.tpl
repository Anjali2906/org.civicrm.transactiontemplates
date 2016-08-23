<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<meta name="viewport" content="width=device-width"/>
		<link rel="stylesheet" href="css/customize.css">
	    <link rel="stylesheet" href="css/foundation-emails.css">
</head>
<body>
    <table class="body">
        <tr>
            <td class="center" align="center" valign="top">
                <center>
                    <table class="container">
                        <tr>
                            <td>
                            <!-- Header -->
                            {transaction.header}

                            <table class="row">
                                <tr>
                                <td class="wrapper last">
                                    <table class="twelve columns">
                                        <tr>
                                            <td class="panel empty"></td>
                                            <td class="expander"></td>
                                        </tr>
                                        <tr>
                                        <td class="panel combined">
                                      <h3>{ts}Activity Summary{/ts} - {$activityTypeName}</h3>
                                      <table>
                                            {if $isCaseActivity}
                                          <tr>
                                           <td class="row-header">
                                                {ts}Your Case Role(s){/ts}
                                           </td>
                                           <td>
                                            {$contact.role}
                                           </td>
                                          </tr>
                                          {if $manageCaseURL}
                                           <tr>
                                               <td>
                                                        <a href="{$manageCaseURL}" title="{ts}Manage Case{/ts}">{ts}Manage Case{/ts}</a>
                                               </td>
                                           </tr>
                                          {/if}
                                         {/if}

                                         {if $editActURL}
                                         <tr>
                                           <td>
                                                 <a href="{$editActURL}" title="{ts}Edit this activity{/ts}">{ts}Edit this activity{/ts}</a>
                                           </td>
                                         </tr>
                                         {/if}
                                         {if $viewActURL}
                                         <tr>
                                           <td>
                                                    <a href="{$viewActURL}" title="{ts}View this activity{/ts}">{ts}View this activity{/ts}</a>
                                           </td>
                                         </tr>
                                         {/if}

                                          {foreach from=$activity.fields item=field}
                                      <tr>
                                        <td class="row-header">
                                            {$field.label}{if $field.category}({$field.category}){/if}
                                        </td>
                                        <td>
                                            {if $field.type eq 'Date'}
                                                {$field.value|crmDate:$config->dateformatDatetime}
                                            {else}
                                                {$field.value}
                                            {/if}
                                        </td>
                                    </tr>
                                     {/foreach}
                                     </table>
                                    </td>
                                    </tr>

                                        {foreach from=$activity.customGroups key=customGroupName item=customGroup}
                                     <tr>
                                        <td class="panel combined">
                                          <h3>{$customGroupName}</h3>
                                           <table>
                                                  {foreach from=$customGroup item=field}
                                                   <tr>
                                                    <td class="row-header">
                                                     {$field.label}
                                                    </td>
                                                    <td>
                                                     {if $field.type eq 'Date'}
                                                      {$field.value|crmDate:$config->dateformatDatetime}
                                                     {else}
                                                      {$field.value}
                                                     {/if}
                                                    </td>
                                                   </tr>
                                                  {/foreach}
                                                </table>
                                              </td>
                                            </tr>
                                     {/foreach}
                                    </table>
                                </td>
                                </tr>
                            </table>

                            <!-- Footer -->
                            {transaction.footer}

                        </td>
                    </tr>
                </table>
            </center>
            </td>
        </tr>
    </table>

</body>
</html>
