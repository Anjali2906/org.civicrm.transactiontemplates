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
												<p>{ts 1=$next_payment|truncate:10:''|crmDate}This is a reminder that the next payment on your pledge is due on %1.{/ts}</p>
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
										<h3>{ts}Payment Due{/ts}</h3>
										<table>
											<tr>
												<td class="row-header">
													{ts}Amount Due{/ts}
												</td>
												<td>
											{$amount_due|crmMoney:$currency}
										  </td>
											</tr>
										</table>
										</td>
									</tr>

									<tr>
								<td class="panel combined">
								<!-- <h3>{ts}Payment Schedule{/ts}</h3> -->
								<table>
									<tr>
										<td>
											  {if $contribution_page_id}
													{capture assign=contributionUrl}{crmURL p='civicrm/contribute/transact' q="reset=1&id=`$contribution_page_id`&cid=`$contact.contact_id`&pledgeId=`$pledge_id`&cs=`$checksumValue`" a=true h=0}{/capture}
													<p><a href="{$contributionUrl}">{ts}Go to a web page where you can make your payment online{/ts}</a></p>
												{else}
												  <p>{ts}Please mail your payment to{/ts}: {$domain.address}</p>
												{/if}
										  </td>
									</tr>
								  </table>
								 </td>
								</tr>

								<tr>
									<td class="panel combined">
									<h3>{ts}Pledge Information{/ts}</h3>
									<table>
										<tr>
										  <td class="row-header">
											{ts}Pledge Received{/ts}
										  </td>
										  <td>
											{$create_date|truncate:10:''|crmDate}
										  </td>
										</tr>
										<tr>
										  <td class="row-header">
											{ts}Total Pledge Amount{/ts}
										  </td>
										  <td>
											{$amount|crmMoney:$currency}
										  </td>
										</tr>
										<tr>
										  <td class="row-header">
											{ts}Total Paid{/ts}
										  </td>
										  <td>
											{$amount_paid|crmMoney:$currency}
											</td>
										</tr>
									  </table>
									  </td>
									</tr>

									<tr>
										<td class="text-pad">
											<table>
												<tr>
												  <td>
													<p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions or need to modify your payment schedule.{/ts}</p>
													<p>{ts}Thank your for your generous support.{/ts}</p>
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
