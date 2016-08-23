<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="viewport" content="width=device-width"/>
	<link rel="stylesheet" href="css/customize.css">
	<link rel="stylesheet" href="css/foundation-emails.css">
</head>
<!--  -->
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
											  {if $formValues.receipt_text}
											   <p>{$formValues.receipt_text|htmlize}</p>
											  {else}
											   <p>{ts}Thank you for your support.{/ts}</p>
											  {/if}
											  <p>{ts}Please print this receipt for your records.{/ts}</p>
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
										  <table>
												<tr>
												  <td class="row-header">
												   {ts}Financial Type{/ts}
												  </td>
												  <td>
												   {$formValues.contributionType_name}
												  </td>
												</tr>
										</table>
									</td>
								</tr>

								<tr>
										<td class="panel combined">
											{if $lineItem and !$is_quick_config}
												{foreach from=$lineItem item=value key=priceset}
												  <table>
													<tr class="header">
													   <td><h6>{ts}Item{/ts}</h6></td>
													   <td><h6>{ts}Qty{/ts}</h6></td>
													   <td><h6>{ts}Each{/ts}</h6></td>
													   {if $getTaxDetails}
														 <td><h6>{ts}Subtotal{/ts}</h6></td>
														 <td><h6>{ts}Tax Rate{/ts}</h6></td>
														 <td><h6>{ts}Tax Amount{/ts}</h6></td>
													   {/if}
													   <td><h6>{ts}Total{/ts}</h6></td>
													</tr>
													{foreach from=$value item=line}
												  <tr>
													<td>
														{if $line.html_type eq 'Text'}{$line.label}{else}{$line.field_title} - {$line.label}
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
											{if $getTaxDetails && $dataArray}
											   <tr>
												 <td class="row-header">
												   {ts} Amount before Tax : {/ts}
												 </td>
												 <td {$valueStyle}>
												   {$formValues.total_amount-$totalTaxAmount|crmMoney:$currency}
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

												{if isset($totalTaxAmount) && $totalTaxAmount !== 'null'}
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
											   {ts}Total Amount{/ts}
											  </td>
											  <td>
											   {$formValues.total_amount|crmMoney:$currency}
											  </td>
											</tr>

											{if $receive_date}
										  <tr>
										   <td class="row-header">
											{ts}Received Date{/ts}
										   </td>
										   <td>
											{$receive_date|truncate:10:''|crmDate}
										   </td>
										  </tr>
										 {/if}

										  {if $receipt_date}
										  <tr>
										   <td class="row-header">
											{ts}Receipt Date{/ts}
										   </td>
										   <td >
											{$receipt_date|truncate:10:''|crmDate}
										   </td>
										  </tr>
										 {/if}

										 {if $formValues.paidBy and !$formValues.hidden_CreditCard}
										  <tr>
										   <td class="row-header">
											{ts}Paid By{/ts}
										   </td>
										   <td >
											{$formValues.paidBy}
										   </td>
										  </tr>
										  {if $formValues.check_number}
										   <tr>
											<td class="row-header">
											 {ts}Check Number{/ts}
											</td>
											<td >
											 {$formValues.check_number}
											</td>
										   </tr>
										  {/if}
										 {/if}

										 {if $formValues.trxn_id}
										  <tr>
										   <td class="row-header">
											{ts}Transaction ID{/ts}
										   </td>
										   <td >
											{$formValues.trxn_id}
										   </td>
										  </tr>
										 {/if}
									  </table>
									</td>
									</tr>

									<tr>
										<td class="panel combined">
										 {if $ccContribution}
										  <h3>{ts}Billing Name and Address{/ts}</h3>
										  <table>
											  <tr>
											   <td class="row-header">
													{$billingName}
												</td>
												<td>
													{$address|nl2br}
											   </td>
											  </tr>
										  </table>
										  <h3>{ts}Credit Card Information{/ts}</h3>
										  <table>
											  <tr>
											   <td>
												{$credit_card_type}
												</td>
											   </tr>
											   <tr>
												<td>
												{$credit_card_number}</td>
											   </tr>
												<td>
												{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:''|crmDate}
											   </td>
											  </tr>
										  </table>
										 {/if}
									</td>
								</tr>

								{if $softCreditTypes and $softCredits}
						  {foreach from=$softCreditTypes item=softCreditType key=n}
						   <tr>
							<td class="panel combined">
							<h3>{$softCreditType}</h3>
							<table>
						   {foreach from=$softCredits.$n item=value key=label}
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
						   {/foreach}
						 {/if}

							{if $customGroup}
								{foreach from=$customGroup item=value key=customName}
								<tr>
									<td class="panel combined">
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

								{if $formValues.product_name}
						  <tr>
							<td class="panel combined">
							<h3>{ts}Premium Information{/ts}</h3>
							<table>
								  <tr>
								   <td class="row-header">
									{$formValues.product_name}
								   </td>
								  </tr>
								  {if $formValues.product_option}
								   <tr>
									<td class="row-header">
									 {ts}Option{/ts}
									</td>
									<td>
									 {$formValues.product_option}
									</td>
								   </tr>
								  {/if}
								  {if $formValues.product_sku}
								   <tr>
									<td class="row-header">
									 {ts}SKU{/ts}
									</td>
									<td>
									 {$formValues.product_sku}
									</td>
								   </tr>
								  {/if}
								  {if $fulfilled_date}
								   <tr>
									<td class="row-header">
									 {ts}Sent{/ts}
									</td>
									<td>
									 {$fulfilled_date|truncate:10:''|crmDate}
									</td>
								   </tr>
								{/if}
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
