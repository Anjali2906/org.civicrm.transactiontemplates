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
													<p>{ts 1=$contact.display_name}Dear %1{/ts},</p>
												</td>
											</tr>
											<tr>
												<td class="text-pad">
													<p>{ts}Your recurring contribution has been updated as requested:{/ts}
													<p>{ts 1=$amount 2=$recur_frequency_interval 3=$recur_frequency_unit}Recurring contribution is for %1, every %2 %3(s){/ts}{if $installments}{ts 1=$installments} for %1 installments{/ts}{/if}.</p>
												</td>
											</tr>
											<tr>
												<td class="text-pad">
													<p>{ts 1=$receipt_from_email}If you have questions please contact us at %1.{/ts}</p>
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
