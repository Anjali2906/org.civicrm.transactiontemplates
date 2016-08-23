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
										  <h3>{ts}Contribution Information{/ts}</h3>
											{if $lineItem and $priceSetID and !$is_quick_config}
											{foreach from=$lineItem item=value key=priceset}
												  <table>
													<tr class="header">
													   <td><h6>{ts}Item{/ts}</h6></td>
													   <td><h6>{ts}Qty{/ts}</h6></td>
													   <td><h6>{ts}Each{/ts}</h6></td>
													   {if $dataArray}
														 <td><h6>{ts}Subtotal{/ts}</h6></td>
														 <td><h6>{ts}Tax Rate{/ts}</h6></td>
														 <td><h6>{ts}Tax Amount{/ts}</h6></td>
													   {/if}
													   <td><h6>{ts}Total{/ts}</h6></td>
													</tr>
													{foreach from=$value item=line}
												  <tr>
													<td>
														{if $line.html_type eq 'Text'}
														{$line.label}{else}{$line.field_title} - {$line.label}
														{/if}
														{if $line.description}
														<div>
															{$line.description|truncate:30:"..."}
														</div>
														{/if}
													</td>
													<td>
															{$line.qty}
													</td>
													<td>
															{$line.unit_price|crmMoney:$currency}
													</td>
													{if $getTaxDetails}
													  <td>
														{$line.unit_price*$line.qty|crmMoney:$currency}
													  </td>
													  {if $line.tax_rate != "" || $line.tax_amount != ""}
														<td>
														  {$line.tax_rate|string_format:"%.2f"}%
														</td>
														<td>
														  {$line.tax_amount|crmMoney:$currency}
														</td>
													  {else}
														<td></td>
														<td></td>
													  {/if}
													{/if}
													<td>
													 {$line.line_total+$line.tax_amount|crmMoney:$currency}
													</td>
												  </tr>
												  {/foreach}
												  </table>
												{/foreach}
												{/if}
									</td>
								</tr>

							<tr>
								<td class="panel combined">
									<table>
											{if $dataArray}
											   <tr>
												 <td class="row-header">
												   {ts} Amount before Tax : {/ts}
												 </td>
												 <td {$valueStyle}>
													{$amount-$totalTaxAmount|crmMoney:$currency}
												 </td>
											   </tr>

											  {foreach from=$dataArray item=value key=priceset}
												{if $priceset ||  $priceset == 0 || $value != ''}
												<tr>
												  <td class="row-header">{$taxTerm} {$priceset|string_format:"%.2f"}%</td>
												  <td>{$value|crmMoney:$currency}</td>
												</tr>
												{else}
												<tr>
												  <td class="row-header">{ts}No{/ts} {$taxTerm}</td>
												  <td>{$value|crmMoney:$currency}</td>
												</tr>
												{/if}
											  {/foreach}
											{/if}

												{if $totalTaxAmount}
										  <tr>
											<td class="row-header">
											  {ts}Total Tax{/ts}
											</td>
											<td>
											  {$totalTaxAmount|crmMoney:$currency}
											</td>
										  </tr>

										  <tr>
											  <td class="row-header">
											   {ts}Total Amount{/ts}
											  </td>
											  <td>
											   {$amount|crmMoney:$currency}
											  </td>
											</tr>
										 <!-- {/if} -->

											{else}
												<!-- {if $totalTaxAmount} -->
											 <tr>
											   <td class="row-header">
												 {ts}Total Tax Amount{/ts}
											   </td>
											   <td>
												 {$totalTaxAmount|crmMoney:$currency}
											   </td>
											 </tr>
											<!-- {/if} -->
											   <tr>
												<td class="row-header">
												 {ts}Amount{/ts}
												</td>
												<td>
												 {$amount|crmMoney:$currency} {if $amount_level} - {$amount_level}{/if}
												</td>
											   </tr>
											{/if}

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
									</table>
								  </td>
								</tr>

								{if $is_recur}
								<tr>
									<td class="panel combined">
										<table>
									  {if $contributeMode eq 'notify' or $contributeMode eq 'directIPN'}
									   <tr>
										<td>
										 {ts 1=$cancelSubscriptionUrl}This is a recurring contribution. You can cancel future contributions by <a href="%1">visiting this web page</a>.{/ts}
										</td>
									 </tr>
										{if $updateSubscriptionBillingUrl}
									 <tr>
										 <td>
										  {ts 1=$updateSubscriptionBillingUrl}You can update billing details for this recurring contribution by <a href="%1">visiting this web page</a>.{/ts}
										 </td>
									   </tr>
										{/if}
									   <tr>
										<td>
										 {ts 1=$updateSubscriptionUrl}You can update recurring contribution amount or change the number of installments for this recurring contribution by <a href="%1">visiting this web page</a>.{/ts}
										</td>
									   </tr>
									  {/if}
									</table>
								  </td>
								</tr>
								{/if}

						{if $honor_block_is_active}
						  <tr>
							  <td class="panel combined">
							<h3>
								{$soft_credit_type}
							</h3>
							  <table>
							  {foreach from=$honoreeProfile item=value key=label}
								<tr>
									<td class="row-header">
									{$label}
									</td>
									<td {$valueStyle}>
									 {$value}
									</td>
								</tr>
							  {/foreach}
							  </table>
							</td>
						  </tr>

						  {elseif $softCreditTypes and $softCredits}
						  {foreach from=$softCreditTypes item=softCreditType key=n}
						  <tr>
							  <td class="panel combined">
							  <h3>{$softCreditType}</h3>
							  <table>
							   {foreach from=$softCredits.$n item=value key=label}
								<tr>
								  <td {$labelStyle}>
								   {$label}
								  </td>
								  <td {$valueStyle}>
								   {$value}
								  </td>
								</tr>
								{/foreach}
							  </table>
							  </td>
						  </tr>
						  {/foreach}
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
									<td {$labelStyle}>
									  {$onBehalfName}
									</td>
									<td {$valueStyle}>
									{$onBehalfValue}
									</td>
								</tr>
							  {/foreach}
							  </table>
							  </td>
						  </tr>
							{/if}

							{if $isShare}
						  <tr>
							<td class="panel combined">
								{capture assign=contributionUrl}{crmURL p='civicrm/contribute/transact' q="reset=1&id=`$contributionPageId`" a=true fe=1 h=1}{/capture}
								{include file="CRM/common/SocialNetwork.tpl" emailMode=true url=$contributionUrl title=$title pageURL=$contributionUrl}
							</td>
						  </tr>
							{/if}


							if ! ($contributeMode eq 'notify' OR $contributeMode eq 'directIPN') and $is_monetary}
						<tr>
							{if $is_pay_later && !$isBillingAddressRequiredForPayLater}
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
							  {elseif $amount GT 0}
							  <tr>
							   <td class="panel combined">
								<h3>{ts}Billing Name and Address{/ts}</h3>
								<table>
									   <tr>
										<td colspan="2" {$valueStyle}>
										 {$billingName}<br />
										 {$address|nl2br}<br />
										 {$email}
										</td>
									   </tr>
									  </table>
									</td>
							  {/if}
						  </tr>
							{/if}

							{if $contributeMode eq 'direct' AND !$is_pay_later AND $amount GT 0}
								<tr>
									<td class="panel combined">
									<h3>{ts}Credit Card Information{/ts}</h3>
									<table>
										<tr>
											<td colspan="2" {$valueStyle}>
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
								  {if $formValues.product_sku}
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
								</table>
								</td>
							</tr>

							<tr>
								<td class="panel combined">
								<table>
							  {if $contact_email OR $contact_phone}
								<tr>
									<td>
									 <p>{ts}For information about this premium, contact:{/ts}</p>
									 {if $contact_email}
									  <p>{$contact_email}</p>
									 {/if}
									 {if $contact_phone}
									  <p>{$contact_phone}</p>
									 {/if}
									</td>
								</tr>
							{/if}

							  {if $is_deductible AND $price}
								<tr>
									<td>
									<p>{ts 1=$price|crmMoney:$currency}The value of this premium is %1. This may affect the amount of the tax deduction you can claim. Consult your tax advisor for more information.{/ts}</p>
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
											 <td {$labelStyle}>
											  {$customName}
											 </td>
											 <td {$valueStyle}>
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
											 <td {$labelStyle}>
											  {$customName}
											 </td>
											 <td {$valueStyle}>
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
