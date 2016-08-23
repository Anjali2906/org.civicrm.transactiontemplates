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
												  {if $formValues.receipt_text_signup}
													<p>{$formValues.receipt_text_signup|htmlize}</p>
												  {elseif $formValues.receipt_text_renewal}
													<p>{$formValues.receipt_text_renewal|htmlize}</p>
												  {else}
													<p>{ts}Thank you for your support.{/ts}</p>
												  {/if}
												  {if ! $cancelled}
													<p>{ts}Please print this receipt for your records.{/ts}</p>
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

									{if !$lineItem}
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
										</table>
										</td>
									  </tr>
								  {/if}

								  {if ! $cancelled}
									  <tr>
											<td class="panel combined">
											<table>
										  {if !$lineItem}
											  <tr>
												<td class="row-header">
													{ts}Membership Start Date{/ts}
												</td>
												<td>
													{$mem_start_date}
												</td>
											   </tr>
											   <tr>
												<td class="row-header">
												 {ts}Membership End Date{/ts}
												</td>
												<td>
												  {$mem_end_date}
												</td>
											  </tr>
										  {/if}
										</table>
										</td>
									  </tr>

									{if $formValues.total_amount OR $formValues.total_amount eq 0 }
										  <tr>
											<td class="panel combined">
											<h3>{ts}Membership Fee{/ts}</h3>
									  <table>
									  {if $formValues.contributionType_name}
										<tr>
											<td class="row-header">
											{ts}Financial Type{/ts}
											</td>
											<td>
											{$formValues.contributionType_name}
											</td>
										</tr>
									  {/if}
												</table>
												</td>
											</tr>

											{if $lineItem}
												<tr>
													<td class="panel combined">
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
													</td>
												</tr>

												<tr>
													<td class="panel combined">
													{if $dataArray}
													<table>
									<tr>
										 <td class="row-header">
										  {ts}Amount Before Tax : {/ts}
										 </td>
										 <td>
										  {$formValues.total_amount-$totalTaxAmount|crmMoney}
										 </td>
									</tr>
									{foreach from=$dataArray item=value key=priceset}
									  {if $priceset}
									  <tr>
										 <td class="row-header">&nbsp;{$taxTerm} {$priceset|string_format:"%.2f"}%</td>
										 <td>&nbsp;{$value|crmMoney:$currency}</td>
									  </tr>
									  {elseif  $priceset == 0}
									  <tr>
										 <td class="row-header">&nbsp;{ts}No{/ts} {$taxTerm}</td>
										 <td>&nbsp;{$value|crmMoney:$currency}</td>
									  </tr>
									  {/if}
									{/foreach}
								  </table>
								  {/if}
													</td>
												</tr>
											{/if}

											<tr>
												<td class="panel combined">
													<table>
														{if isset($totalTaxAmount)}
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
															{$formValues.total_amount|crmMoney}
														</td>
													 </tr>
													</table>
												</td>
											</tr>

								  <tr>
									<td class="panel combined">
									<table>
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

										  {if $formValues.paidBy}
											<tr>
											 <td class="row-header">
											  {ts}Paid By{/ts}
											 </td>
											 <td>
											  {$formValues.paidBy}
											 </td>
											</tr>
											{if $formValues.check_number}
											 <tr>
											  <td class="row-header">
											   {ts}Check Number{/ts}
											  </td>
											  <td>
											   {$formValues.check_number}
											  </td>
											 </tr>
											{/if}
										  {/if}
										</table>
										</td>
									  </tr>

										{/if}
									{/if}

									{if $isPrimary}
										{if $contributeMode ne 'notify' and !$isAmountzero and !$is_pay_later }
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
										{if $contributeMode eq 'direct' and !$isAmountzero and !$is_pay_later}
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
													<tr>
														<td class="row-header">
												 {ts}Expires{/ts}
												</td>
												<td>
												 {$credit_card_exp_date|truncate:7:''|crmDate}
												</td>
													</tr>
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
