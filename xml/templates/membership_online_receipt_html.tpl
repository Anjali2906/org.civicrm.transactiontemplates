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
												  {if $receipt_text}
												<p>{$receipt_text|htmlize}</p>
												{/if}

												{if $is_pay_later}
												 <p>{$pay_later_receipt}</p> {* FIXME: this might be text rather than HTML *}
												{else}
												 <p>{ts}Please print this confirmation for your records.{/ts}</p>
												{/if}
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
										<h3>{ts}Membership Information{/ts}</h3>
										<table>
									  <tr>
										<td class="row-header">
										  {ts}Membership Type{/ts}
										</td>
										<td>
										{$membership_name}
										</td>
									  </tr>
									  {if $mem_start_date}
									   <tr>
										<td class="row-header">
											{ts}Membership Start Date{/ts}
										</td>
										<td>
											{$mem_start_date|crmDate}
										</td>
									   </tr>
									  {/if}
									  {if $mem_end_date}
									   <tr>
										<td class="row-header">
										 {ts}Membership End Date{/ts}
										</td>
										<td>
										  {$mem_end_date|crmDate}
										</td>
									   </tr>
									  {/if}
										</table>
										</td>
									</tr>

									{if $amount}
										<tr>
											<td class="panel combined">
											<h3>{ts}Membership Fee{/ts}</h3>


											{if !$useForMember and $membership_amount and $is_quick_config}
											<table>
										  <tr>
												<td class="row-header">
												 {ts 1=$membership_name}%1 Membership{/ts}
												</td>
												<td>
												 {$membership_amount|crmMoney}
												</td>
										  </tr>
										  {if $amount}
											{if ! $is_separate_payment }
											<tr>
											  <td class="row-header">
											   {ts}Contribution Amount{/ts}
											  </td>
											  <td>
											   {$amount|crmMoney}
											  </td>
											</tr>
											{else}
											 <tr>
												  <td class="row-header">
												   {ts}Additional Contribution{/ts}
												  </td>
												  <td>
												   {$amount|crmMoney}
												  </td>
											 </tr>
											{/if}
											{/if}
											<tr>
											<td class="row-header">
											 {ts}Total{/ts}
											</td>
											<td>
											 {$amount+$membership_amount|crmMoney}
											</td>
										</tr>
											</table>

											{elseif !$useForMember && $lineItem and $priceSetID and !$is_quick_config}

											{foreach from=$lineItem item=value key=priceset}
										  <table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}
											  <tr class="header">
												<td><h6>{ts}Item{/ts}</h6></td>
												<td><h6>{ts}Qty{/ts}</h6></td>
												<td><h6>{ts}Each{/ts}</h6></td>
												<td><h6>{ts}Total{/ts}</h6></td>
											  </tr>
										   {foreach from=$value item=line}
											<tr>
												<td>
												{$line.description|truncate:30:"..."}
												</td>
												<td>
												{$line.qty}
												</td>
												<td>
												{$line.unit_price|crmMoney}
												</td>
												<td>
												{$line.line_total|crmMoney}
												</td>
											</tr>
										   {/foreach}
										  </table>
											{/foreach}
									<table>
										<tr>
											<td class="row-header">
											 {ts}Total Amount{/ts}
											</td>
											<td>
											 {$amount|crmMoney}
											</td>
										</tr>
									</table>

									{else}

									{if $useForMember && $lineItem and !$is_quick_config}
											{foreach from=$lineItem item=value key=priceset}
											<table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}
												<tr class="header">
													<td><h6>{ts}Item{/ts}</h6></td>
													<td><h6>{ts}Fee{/ts}</h6></td>
													{if $dataArray}
															<td><h6>{ts}SubTotal{/ts}</h6></td>
															<td><h6>{ts}Tax Rate{/ts}</h6></td>
															<td><h6>{ts}Tax Amount{/ts}</h6></td>
															<td><h6>{ts}Total{/ts}</h6></td>
													{/if}
													<td><h6>{ts}Membership Start Date{/ts}</h6></td>
													<td><h6>{ts}Membership End Date{/ts}</h6></td>
												</tr>
												{foreach from=$value item=line}
													<tr>
														<td>
														{if $line.html_type eq 'Text'}
															{$line.label}{else}{$line.field_title} - {$line.label}
														{/if}
														{if $line.description}
															<div>{$line.description|truncate:30:"..."}</div>
														{/if}
														</td>
														<td>
															{$line.line_total|crmMoney}
														</td>
														{if $dataArray}
															<td>
																{$line.unit_price*$line.qty|crmMoney}
															</td>
															{if $line.tax_rate != "" || $line.tax_amount != ""}
																<td>
																	{$line.tax_rate|string_format:"%.2f"}%
																</td>
																<td>
																	{$line.tax_amount|crmMoney}
																</td>
															{else}
																<td></td>
																<td></td>
															{/if}
															<td>
																{$line.line_total+$line.tax_amount|crmMoney}
															</td>
														{/if}
														<td>
															{$line.start_date}
														</td>
														<td>
														{$line.end_date}
													 </td>
													</tr>
												{/foreach}
											</table>
											{/foreach}
											{/if}

											{/if}
											</td>
										</tr>

										<tr>
											<td class="panel combined">
											<table>
												{if $totalTaxAmount}
												<tr>
													<td class="row-header">
														{ts}Total Tax Amount{/ts}
													</td>
													<td>
														{$totalTaxAmount|crmMoney:$currency}
													</td>
												</tr>
												{/if}
											 <tr>
												<td class="row-header">
												 {ts}Amount{/ts}
												</td>
												<td>
												 {$amount|crmMoney} {if $amount_level} - {$amount_level}{/if}
												</td>
											 </tr>
											</table>
											</td>
										</tr>
									{/if}

									{elseif $membership_amount}
									<tr>
										<td class="panel combined">
										<h3>{ts}Membership Fee{/ts}</h3>
										<table>
											<tr>
											 <td class="row-header">
												{ts 1=$membership_name}%1 Membership{/ts}
											 </td>
											 <td>
												{$membership_amount|crmMoney}
											 </td>
											</tr>
										</table>
										</td>
									</tr>
									{/if}

									<tr>
										<td class="panel combined">
										<table>
											{if $receive_date}
											<tr>
												<td class="row-header">
													{ts}Date{/ts}
												</td>
												<td>
													{$receive_date|crmDate}
												</td>
											</tr>
										 {/if}
										 {if $is_monetary and $trxn_id}
											<tr>
												<td class="row-header">
													{ts}Transaction #{/ts}
												</td>
												<td>
													{$trxn_id}
												</td>
											</tr>
										 {/if}
										 {if $membership_trx_id}
											<tr>
												<td class="row-header">
													{ts}Membership Transaction #{/ts}
												</td>
												<td>
													{$membership_trx_id}
												</td>
											</tr>
										 {/if}
										</table>
										</td>
									</tr>

									<tr>
										<td class="panel combined">
										<table>
										 {if $is_recur}
											{if $contributeMode eq 'notify' or $contributeMode eq 'directIPN'}
											 <tr>
												<td>
												 {ts 1=$cancelSubscriptionUrl}This membership will be renewed automatically. You can cancel the auto-renewal option by <a href="%1">visiting this web page</a>.{/ts}
												</td>
											 </tr>
											 <tr>
												<td>
												 {ts 1=$updateSubscriptionBillingUrl}You can update billing details for this automatically renewed membership by <a href="%1">visiting this web page</a>.{/ts}
												</td>
											 </tr>
											{/if}
										 {/if}
										</table>
										</td>
									</tr>

									{if $honor_block_is_active}
									<tr>
										<td class="panel combined">
										<h3>{$soft_credit_type}</h3>
										<table>
										{foreach from=$honoreeProfile item=value key=label}
											<tr>
											 <td class="row-header">
												{$label}
											 </td>
											 <td>
												{$value}
											 </td>
											</tr>
										{/foreach}
										</table>
										</td>
									</tr>
									{/if}

									{if $pcpBlock}
									<tr>
										<td class="panel combined">
										<h3>{ts}Personal Campaign Page{/ts}</h3>
										<table>
											<tr>
												<td class="row-header">
													{ts}Display In Honor Roll{/ts}
												</td>
												<td>
												{if $pcp_display_in_roll}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}
												</td>
											</tr>
											{if $pcp_roll_nickname}
											<tr>
												<td class="row-header">
													{ts}Nickname{/ts}
												</td>
												<td>
													{$pcp_roll_nickname}
												</td>
											</tr>
											{/if}
											{if $pcp_personal_note}
											<tr>
												<td class="row-header">
												 {ts}Personal Note{/ts}
												</td>
												<td>
												 {$pcp_personal_note}
												</td>
											</tr>
											{/if}
										</table>
										</td>
									</tr>
									{/if}

									{if $onBehalfProfile}
									<tr>
										<td class="panel combined">
										<h3>{$onBehalfProfile_grouptitle}</h3>
										<table>
										{foreach from=$onBehalfProfile item=onBehalfValue key=onBehalfName}
											<tr>
												<td class="row-header">
													{$onBehalfName}
												</td>
												<td>
													{$onBehalfValue}
												</td>
											</tr>
										{/foreach}
										</table>
										</td>
									</tr>
									{/if}

									{if ! ($contributeMode eq 'notify' OR $contributeMode eq 'directIPN') and $is_monetary}
										{if $is_pay_later}
										<tr>
											<td class="panel combined">
											<h3>{ts}Registered Email{/ts}</h3>
											<table>
												<tr>
													<td colspan="2" {$valueStyle}>
													{$email}
													</td>
												</tr>
											</table>
											</td>
										</tr>
										{elseif $amount GT 0 OR $membership_amount GT 0}
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
										{/if}
									{/if}

									{if $contributeMode eq 'direct' AND !$is_pay_later AND ($amount GT 0 OR $membership_amount GT 0)}
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
											</tr>
										</table>
										</td>
									</tr>
									{/if}

									{if $selectPremium}
									<tr>
										<td class="panel combined">
											<h3>{ts}Premium Information{/ts}</h3>
											<table>
											<tr>
												<td class="row-header">
													{$product_name}
												</td>
											</tr>
											{if $option}
												<tr>
													<td class="row-header">
														{ts}Option{/ts}
													</td>
													<td>
														{$option}
													</td>
												</tr>
											{/if}
											{if $sku}
												<tr>
													<td class="row-header">
														{ts}SKU{/ts}
													</td>
													<td>
														{$sku}
													</td>
												</tr>
											{/if}

											{if $start_date}
												<tr>
													<td class="row-header">
													 {ts}Start Date{/ts}
													</td>
													<td>
													 {$start_date|crmDate}
													</td>
												</tr>
											{/if}

											{if $end_date}
												<tr>
													<td class="row-header">
													 {ts}End Date{/ts}
													</td>
													<td>
													 {$end_date|crmDate}
													</td>
												</tr>
											{/if}

											{if $contact_email OR $contact_phone}
												<tr>
													<td class="row-header">
													 <p>{ts}For information about this premium, contact:{/ts}</p>
													</td>
												</tr>
												<tr>
													{if $contact_email}
													<td>
														<p>{$contact_email}</p>
													</td>
													{/if}
													{if $contact_phone}
													<td>
														<p>{$contact_phone}</p>
													</td>
													{/if}
												</tr>
											{/if}

											{if $is_deductible AND $price}
												<tr>
													<td colspan="2">
														<p>{ts 1=$price|crmMoney}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}</p>
													</td>
												</tr>
											{/if}
											</table>
											</td>
										</tr>
									 {/if}

									 {if $customPre}
										<tr>
											<td class="panel combined">
											<h3>{$customPre_grouptitle}</h3>
											<table>
											{foreach from=$customPre item=customValue key=customName}
											 {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}
												<tr>
													<td class="row-header">
														{$customName}
													</td>
													<td>
														{$customValue}
													</td>
												</tr>
											 {/if}
											{/foreach}
											</table>
											</td>
										</tr>
									 {/if}

									 {if $customPost}
										<tr>
										 <td class="panel combined">
											<h3>{$customPost_grouptitle}</h3>
											<table>
											{foreach from=$customPost item=customValue key=customName}
											 {if ($trackingFields and ! in_array($customName, $trackingFields)) or ! $trackingFields}
												<tr>
													<td class="row-header">
														{$customName}
													</td>
													<td>
														{$customValue}
													</td>
												</tr>
											 {/if}
											{/foreach}
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
