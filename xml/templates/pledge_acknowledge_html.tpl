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
												<td class="text-pad">
													<p>{ts 1=$contact.display_name}dear %1{/ts},</p>
												<p>{ts}thank you for your generous pledge. please print this acknowledgment for your records.{/ts}</p>
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
											{$total_pledge_amount|crmMoney:$currency}
										  </td>
											</tr>
										{/if}
										</table>
										</td>
									</tr>

									<tr>
								<td class="panel combined">
								<h3>{ts}Payment Schedule{/ts}</h3>
								<table>
									<tr>
										<td>
											   <p>{ts 1=$scheduled_amount|crmMoney:$currency 2=$frequency_interval 3=$frequency_unit 4=$installments}%1 every %2 %3 for %4 installments.{/ts}</p>

											   {if $frequency_day}
												<p>{ts 1=$frequency_day 2=$frequency_unit}Payments are due on day %1 of the %2.{/ts}</p>
											   {/if}
										  </td>
									</tr>
								  </table>
								  <table>
									{if $payments}
									  {assign var="count" value="1"}
									  {foreach from=$payments item=payment}
									  <tr>
										<td class="row-header">
											{ts 1=$count}Payment %1{/ts}
										</td>
										<td>
											{$payment.amount|crmMoney:$currency} {if $payment.status eq 1}{ts}paid{/ts} {$payment.receive_date|truncate:10:''|crmDate}{else}{ts}due{/ts} {$payment.due_date|truncate:10:''|crmDate}{/if}
										</td>
									  </tr>
									  {assign var="count" value=`$count+1`}
									  {/foreach}
										{/if}
								  </table>
								 </td>
								</tr>

								<tr>
									<td class="text-pad">
									<table>
										<tr>
											<td>
											  <p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions or need to modify your payment schedule.{/ts}</p>
											</td>
										</tr>
									</table>
									</td>
								</tr>

								<tr>
									<td class="panel combined">
									{if $customGroup}
								  {foreach from=$customGroup item=value key=customName}
								<h3>{$customName}</h3>
								  <table>
									{foreach from=$value item=v key=n}
										<tr>
											<td class="row-header">
											{$n}
											</td>
											<td>
											{$v}
											</td>
										</tr>
									{/foreach}
								  </table>
								  {/foreach}
									{/if}
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
