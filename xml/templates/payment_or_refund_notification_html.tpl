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
													<p>Dear {contact.display_name},</p>
													{if $paymentConfig.confirm_email_text}
														<p>{$paymentConfig.confirm_email_text|htmlize}</p>
													{elseif $isRefund}
														<p>{ts}A refund has been issued based on changes in your registration selections.{/ts}</p>
													{else}
														<p>{ts}A payment has been received.{/ts}</p>
														{/if}
													<p>{ts}Please print this confirmation for your records.{/ts}</p>
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

									{if $isRefund}
									<tr>
										<td class="panel combined">
											  <h3>{ts}Refund Details{/ts}</h3>
											  <table>
												  <tr>
													<td> <strong>{ts}Total Fees{/ts}</strong></td>
													<td>{$totalAmount|crmMoney}</td>
												  </tr>
												  <tr>
													<td><strong>{ts}You Paid{/ts}</td>
													<td>{$totalPaid|crmMoney}</td>
												  </tr>
												  <tr>
													<td><strong>{ts}Refund Amount{/ts}</strong></td>
													<td>{$refundAmount|crmMoney}<td>
													</tr>
											 </table>
										</td>
									</tr>
									{else}
									<tr>
										<td class="panel combined">
											<h3>{ts}Payment Details{/ts}</h3>
											<table>
											<tr>
												{ts}{if $component eq 'event'}
												<td>
													<strong>
														Total Fees
													</strong>
												</td>
												{/if}{/ts}
											  <td>
														{$totalAmount|crmMoney}
											  </td>
											</tr>
											<tr>
											  <td><strong>{ts}This Payment Amount{/ts}</strong></td>
											  <td>{$paymentAmount|crmMoney}</td>
											</tr>
											<tr>
												<td>
													<strong>
														{ts}Balance Owed{/ts}
													</strong>
												</td>
												<td>
														{$amountOwed|crmMoney}
												</td> {* This will be zero after final payment. *}
											 </tr>

											 <tr>
													<td class="panel empty"></td>
													<td class="expander"></td>
												</tr>
											  {if $paymentsComplete}
											  <tr>
												<td>
														{ts}Thank-you. This completes your payment for {if $component eq 'event'}{$event.event_title}{/if}.{/ts}
											  </td>
											 </tr>
											  {/if}
											</table>
										</td>
									</tr>
									{/if}
									{if}
									<tr>
										<td class="panel combined">
											<table>
											{if $receive_date}
											<tr>
											  <td>
												<strong>
													  {ts}Transaction Date{/ts}
													  </strong>
											  </td>
											  <td>
													{$receive_date|crmDate}
											  </td>
											</tr>
										  {/if}
										  {if $trxn_id}
											<tr>
											  <td>
													<strong>{ts}Transaction #{/ts}
											  </td>
											  <td>
												{$trxn_id}
											  </td>
											</tr>
										  {/if}
										  {if $paidBy}
											<tr>
											  <td>
												<strong>{ts}Paid By{/ts}</strong>
											  </td>
											  <td>
												{$paidBy}
											  </td>
											</tr>
										  {/if}
										  {if $checkNumber}
											<tr>
											  <td>
												<strong>{ts}Check Number{/ts}</strong>
											  </td>
											  <td>
												{$checkNumber}
											  </td>
											</tr>
										  {/if}
										  </table>
										</td>
									</tr>

									{if $contributeMode eq 'direct' and !$isAmountzero}
									<tr>
										<td class="panel combined">
											<h3>{ts}Billing Name and Address{/ts}</h3>
											<table>
												<tr>
													<td>{$billing_name}<td/>
													<td>{$address|nl2br}</td>
												</tr>
											</table>
										</td>
									</tr>
									{/if}
										{if $contributeMode eq'direct' and !$isAmountzero}
										<tr>
											<td class="panel combined">
												<h3>{ts}Credit Card Information{/ts}</h3>
												<table>
													<tr>
														<td>{$credit_card_type}</td>
														<td>{$credit_card_number}</td>
														<td>{ts}Expires{/ts}: {$credit_card_exp_date.M}/{$credit_card_exp_date.Y}</td>
													</tr>
												</table>
											</td>
										</tr>
										{/if}

										{if $component eq 'event'}
											<tr>
												<td class="panel combined">
												<h3>{ts}Event Information and Location{/ts}</h3>
												<table>
													<tr>
														<td><strong>{$event.event_title}</strong></td>
													</tr>
													<tr>
														<td>
															{$event.event_start_date|crmDate}
															{if $event.event_end_date}-
																{if $event.event_end_date|date_format:"%Y%m%d" == $event.event_start_date|date_format:"%Y%m%d"}
																	{$event.event_end_date|crmDate:0:1}
																{else}
																	{$event.event_end_date|crmDate}
																{/if}
															{/if}
														</td>
													</tr>
												</table>
												</td>
												<td class="expander"></td>
											</tr>

											{if $event.participant_role neq 'Attendee' and $defaultRole}
											<tr>
												<td class="panel combined">
													<h3>{ts}Participant Role{/ts}</h3>
													<table>
														<tr>
															<td>{$participant.role}</td>
														</tr>
													</table>
												</td>
											</tr>
											{/if}

											{if $isShowLocation}
											<tr>
												<td class="panel combined">
													<table>
															{$event.location.address.1.display|nl2br}
													</table>
												</td>
											</tr>
											{/if}

											{if $location.phone.1.phone || $location.email.1.email}
												<tr>
												 <td class="panel combined">
													<h3>{ts}Event Contacts:{/ts}</h3>
													<table>
														{foreach from=$event.location.phone item=phone}
														 {if $phone.phone}
															<tr>
															 <td class="row-header">
																{if $phone.phone_type}
																	{$phone.phone_type_display}
																{else}
																	{ts}Phone{/ts}
																{/if}
															 </td>
															 <td>{$phone.phone}</td>
															</tr>
														 {/if}
														{/foreach}
														{foreach from=$event.location.email item=eventEmail}
														 {if $eventEmail.email}
															<tr>
															 <td class="row-header">
																{ts}Email{/ts}
															 </td>
															 <td>{$eventEmail.email}</td>
															</tr>
														 {/if}
														{/foreach}
													</table>
												 </td>
												</tr>
											{/if}
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
