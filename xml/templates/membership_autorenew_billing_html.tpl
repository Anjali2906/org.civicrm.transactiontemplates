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
												<p>{ts 1=$membershipType}Billing details for your automatically renewed %1 membership have been updated.{/ts}</p>
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
										<h3> {ts}Billing Name and Address{/ts}</h3>
										<table>
											<tr>
												<td>
													{$billingName}<br />
													{$address|nl2br}<br />
													{$email}
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td class="panel combined">
										<h3>{ts}Credit Card Information{/ts}</h3>
										<table>
											<tr>
												<td>
													{$credit_card_type}<br />
													{$credit_card_number}<br />
													{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:''|crmDate}<br />
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

							<table class="row">
								<tr>
									<td class="wrapper last">
										<table class="twelve columns">
										{if $event.allow_selfcancelxfer }
									 <tr>
									  <td class="text-pad">
										{ts 1=$receipt_from_email}If you have questions please contact us at %1{/ts}
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
