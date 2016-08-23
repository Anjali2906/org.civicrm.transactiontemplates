<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="viewport" content="width=device-width"/>
	<link rel="stylesheet" href="../../css/customize.css">
	<link rel="stylesheet" href="../../css/foundation-emails.css">
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
											<td class="text-pad">
												<p>{ts}A contribution / membership signup was made on behalf of the organization listed below.{/ts}</p>
											<p>{ts}The information provided matched multiple existing database records based on the configured Duplicate Matching Rules for your site.{/ts}</p>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>

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
										  <table>
												<tr>
												  <td class="row-header">
												   {ts}Organization Name{/ts}
												  </td>
												  <td>
												   {$onBehalfName}
												  </td>
												</tr>
												 <tr>
												  <td class="row-header">
												   {ts}Organization Email{/ts}
												  </td>
												  <td>
												   {$onBehalfEmail}
												  </td>
												 </tr>
												 <tr>
												  <td class="row-header">
												   {ts}Organization Contact ID{/ts}
												  </td>
												  <td>
												   {$onBehalfID}
												  </td>
												</tr>
										</table>
									  </td>
								</tr>
								</table>
							</td>
						</tr>
					</table>

					<table class="row">
							<tr>
								<td class="wrapper last">
									<table class="twelve columns">
									<tr>
										<td class="text-pad">
											<p>{ts}If you think this may be a duplicate contact which should be merged with an existing record - Go to "Contacts >> Find and Merge Duplicate Contacts". Use the strict rule for Organizations to find the potential duplicates and merge them if appropriate.{/ts}</p>
									   </td>
									 </tr>
									</table>
								</td>
							</tr>
						</table>

						<table class="row">
							<tr>
								<td class="wrapper last">
									<table class="twelve columns">
									<tr>
										<td class="panel empty"></td>
										<td class="expander"></td>
									</tr>
									  {if $receiptMessage}
									   <tr>
										<td class="panel combined">
											<table>
										  <tr>
											<td class="row-header">{ts}Copy of Contribution Receipt{/ts}</td>
										</tr>
										<tr>
										   <td>
											{* FIXME: the below is most probably not HTML-ised *}
											{$receiptMessage}
										   </td>
										   </tr>
										 </table>
										</td>
									   </tr>
									  {/if}

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
