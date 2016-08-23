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
													<p>Dear {contact.display_name},</p>
													{if $is_pay_later}
														<p>
															This is being sent to you as an acknowledgement that you have registered one or more members for the following workshop, event or purchase. Please note, however, that the status of your payment is pending, and the registration for this event will not be completed until your payment is received.
														</p>
													{else}
														<p>
															This is being sent to you as a
															{if $is_refund}confirmation of refund{else}receipt of payment made{/if}
															for the following workshop, event registration or purchase.
														</p>
													{/if}

													{if $is_pay_later}
														<p>{$pay_later_receipt}</p>
													{/if}

													<p>Your order number is #{$transaction_id}. Please print this confirmation for your records.
													{if $line_items && !$is_refund}
													Information about the workshops will be sent separately to each participant.{/if}
												Here's a summary of your transaction placed on {$transaction_date|date_format:"%D %I:%M %p %Z"}:</p>
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

											{if $billing_name}
											<tr>
												<td class="panel combined">
													<h3>{ts}Billing Name and Address{/ts}</h3>
													<table>
														<tr>
															<td>{$billing_name}<td/>
														</tr>
														<tr>
															<td>{$billing_street_address}</td>
														</tr>
														<tr>
															<td>{$billing_city}, {$billing_state} {$billing_postal_code}</td>
														</tr>
														<tr>
															<td>{$email}</td>
														</tr>
													</table>
												</td>
											</tr>
										{/if}
										{if $credit_card_type}
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
										{if $source}
										<tr>
											<td class="panel combined">
														{$source}
											</td>
										</tr>
										{/if}


										<tr>
											<td class="panel combined">
											<h3></h3>
											<table>
												<tr class="header">
													{if $line_items}
														<td><h6>Event</h6></td>
														<td><h6>Participants</h6></td>
													{/if}
														<td><h6>Price</h6></td>
														<td><h6>Total</h6></td>
												</tr>
												<tr>
													{foreach from=$line_items item=line_item}
													<td>
														<table>
															<tr>
																<td>
																{$line_item.event->title} ({$line_item.event->start_date|date_format:"%D"})</td>
															</tr>
															{if $line_item.event->is_show_location}
																	{$line_item.location.address.1.display|nl2br}
															{/if}{*End of isShowLocation condition*}
														</table>
													</td>
													<td>
														{$line_item.event->start_date|date_format:"%D %I:%M %p"} - {$line_item.event->end_date|date_format:"%I:%M %p"}
													</td>
													<td>
														{$line_item.num_participants}
															{if $line_item.num_participants > 0}
															<div>
																{foreach from=$line_item.participants item=participant}
																{$participant.display_name}
																{/foreach}
															</div>
															{/if}
															{if $line_item.num_waiting_participants > 0}
															Waitlisted:
															<div>
																{foreach from=$line_item.waiting_participants item=participant}
																{$participant.display_name}
																{/foreach}
															</div>
															{/if}
													</td>
													<td>
														{$line_item.cost|crmMoney:$currency|string_format:"%10s"}
													</td>
													<td>
														{$line_item.amount|crmMoney:$currency|string_format:"%10s"}
													</td>
													{/foreach}
												</tr>
												{if $discounts}
													<tr>
														<td>
														</td>
														<td>
														</td>
														<td>
															Subtotal:
														</td>
														<td>
															{$sub_total|crmMoney:$currency|string_format:"%10s"}
														</td>
													</tr>
													{foreach from=$discounts key=myId item=i}
														<tr>
															<td>
																<strong>{$i.title}</strong>
															</td>
															<td>
																-{$i.amount}
															</td>
														</tr>
													{/foreach}
												{/if}
												<tr>
													{if $line_items}
														<td>
														</td>
														<td>
														</td>
													{/if}
														<td>
															<strong>Total:</strong>
														</td>
														<td>
															<strong>&nbsp;{$total|crmMoney:$currency|string_format:"%10s"}</strong>
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
												<p> If you have questions about the status of your registration or purchase please feel free to contact us.</p>
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
