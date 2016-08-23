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
										<table>
										<tr>
									  <td class="row-header">
									   {ts}Submitted For{/ts}
									  </td>
									  <td>
									   {$displayName}
									  </td>
									 </tr>
									 <tr>
									  <td class="row-header">
									   {ts}Date{/ts}
									  </td>
									  <td>
									   {$currentDate}
									  </td>
									 </tr>
									 <tr>
									  <td class="row-header">
									   {ts}Contact Summary{/ts}
									  </td>
									  <td>
									   {$contactLink}
									  </td>
									 </tr>
											</table>
											</td>
										</tr>

									<tr>
								<td class="panel combined">
								<h3>{$grouptitle}</h3>
								<table>
										 {foreach from=$values item=value key=valueName}
										  <tr>
										   <td class="row-header">
											{$valueName}
										   </td>
										   <td>
											{$value}
										   </td>
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
