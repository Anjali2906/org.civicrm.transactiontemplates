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
								<h3>{ts}Personal Campaign Page Notification{/ts}</h3>
								<table>
									<tr>
							      <td class="row-header">
							       {ts}Action{/ts}:
							      </td>
							      <td>
							       {if $mode EQ 'Update'}
							        {ts}Updated personal campaign page{/ts}
							       {else}
							        {ts}New personal campaign page{/ts}
							       {/if}
							      </td>
							    </tr>
							    <tr>
							      <td class="row-header">
							       {ts}Personal Campaign Page Title{/ts}
							      </td>
							      <td>
							       {$pcpTitle}
							      </td>
							    </tr>
							    <tr>
							      <td class="row-header">
							       {ts}Current Status{/ts}
							      </td>
							      <td>
							       {$pcpStatus}
							      </td>
							    </tr>
							    <tr>
							      <td class="row-header">
							       	<a href="{$pcpURL}">{ts}View Page{/ts}</a>
							      </td>
							      <td></td>
							    </tr>
							    <tr>
							      <td class="row-header">
							       	{ts}Supporter{/ts}
							      </td>
							      <td>
							       	<a href="{$supporterUrl}">{$supporterName}</a>
							      </td>
							    </tr>
							    <tr>
							      <td class="row-header">
							       	{ts}Linked to Contribution Page{/ts}
							      </td>
							      <td>
							       	<a href="{$contribPageUrl}">{$contribPageTitle}</a>
							      </td>
							    </tr>
							    <tr>
							      <td class="row-header">
							       	<a href="{$managePCPUrl}">{ts}Manage Personal Campaign Pages{/ts}</a>
							      </td>
							      <td></td>
							    </tr>
								</table>
								</td>
							</tr>

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
