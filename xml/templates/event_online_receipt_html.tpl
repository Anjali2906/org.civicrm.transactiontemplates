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
													<p>{contact.email_greeting},</p>

													{if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}
														<p>{$event.confirm_email_text|htmlize}</p>

													{else}
														<p>Thank you for your participation.  This letter is a confirmation that your registration has been received and your status has been updated to
															<strong>
															{if $participant_status}
																{$participant_status}
															{else}
																{if $isOnWaitlist}
																	waitlisted{else}registered
																{/if}
															{/if}
															</strong>.
														</p>

													{/if}

													<p>
													{if $isOnWaitlist}
														<p>{ts}You have been added to the WAIT LIST for this event.{/ts}</p>
														{if $isPrimary}
															<p>{ts}If space becomes available you will receive an email with a link to a web page where you can complete your registration.{/ts}</p>
														{/if}
													{elseif $isRequireApproval}
														<p>{ts}Your registration has been submitted.{/ts}</p>
														{if $isPrimary}
															<p>{ts}Once your registration has been reviewed, you will receive an email with a link to a web page where you can complete the registration process.{/ts}</p>
														{/if}
													{elseif $is_pay_later && !$isAmountzero && !$isAdditionalParticipant}
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
																	{else}{$event.event_end_date|crmDate}
																	{/if}
															{/if}
														</td>
													</tr>
											</table>
										<td class="expander"></td>
									</tr>

									{if $conference_sessions}
									<tr>
										<td class="panel combined">
										<h3>{ts}Your schedule:{/ts}</h3>
										<table>
											<tr>
												<td>
													{assign var='group_by_day' value='NA'}
													{foreach from=$conference_sessions item=session}
															{if $session.start_date|date_format:"%Y/%m/%d" != $group_by_day|date_format:"%Y/%m/%d"}
																{assign var='group_by_day' value=$session.start_date}
																		<em>{$group_by_day|date_format:"%m/%d/%Y"}</em><br />
															{/if}
															{$session.start_date|crmDate:0:1}{if $session.end_date}-{$session.end_date|crmDate:0:1}{/if} {$session.title}<br />
															{if $session.location}&nbsp;&nbsp;&nbsp;&nbsp;
																{$session.location}<br />
															{/if}
													{/foreach}
											 </td>
											</tr>
										</table>
										<td class="expander">
									 </td>
									</tr>
									{/if}

									{if $event.participant_role neq 'Attendee' and $defaultRole}
										<tr>
											<td class="panel combined">
												<h3>{ts}Participant Role{/ts}</h3>
													<table>
														<tr>
															<td>{$event.participant_role}</td>
														</tr>
													</table>
											</td>
										</tr>
									{/if}

									{if $isShowLocation}
										<tr>
											<td class="panel combined">
												<table>
													{$location.address.1.display|nl2br}
												</table>
											</td>
										</tr>
									{/if}

									{if $location.phone.1.phone || $location.email.1.email}
										<tr>
											<td class="panel combined">
												<h3>{ts}Event Contacts:{/ts}</h3>
												<table>
													{foreach from=$location.phone item=phone}
														{if $phone.phone}
															<tr>
																<td class="row-header">
																	{if $phone.phone_type}{$phone.phone_type_display}
																	{else}{ts}Phone{/ts}
																	 {/if}
																</td>
																<td>{$phone.phone} {if $phone.phone_ext}&nbsp;{ts}ext.{/ts} {$phone.phone_ext}{/if}</td>
															</tr>
														{/if}
													{/foreach}
													{foreach from=$location.email item=eventEmail}
														{if $eventEmail.email}
															<tr>
																<td class="row-header">{ts}Email{/ts}</td>
																<td>{$eventEmail.email}</td>
															</tr>
														{/if}
													{/foreach}
												</table>
											</td>
										</tr>
									{/if}

									<tr>
										<td class="panel combined">
											<table>
												{if $event.is_public}
														<tr>
																<td>
																		{capture assign=icalFeed}{crmURL p='civicrm/event/ical' q="reset=1&id=`$event.id`" h=0 a=1 fe=1}{/capture}
																		<a href="{$icalFeed}">{ts}Download iCalendar File{/ts}</a>
																</td>
														</tr>
												{/if}
												{if $event.is_share}
													<tr>
															<td>
																	{capture assign=eventUrl}{crmURL p='civicrm/event/info' q="id=`$event.id`&reset=1" a=true fe=1 h=1}{/capture}
																	{include file="CRM/common/SocialNetwork.tpl" emailMode=true url=$eventUrl title=$event.title pageURL=$eventUrl}
															</td>
													</tr>
												{/if}
											</table>
										</td>
									</tr>

									{if $payer.name}
										<tr>
											<td class="panel combined">
											<h3>{ts}You were registered by:{/ts}</h3>
												<table>
													<tr>
														 <td>
															{$payer.name}
														 </td>
													</tr>
												</table>
											</td>
										</tr>
									{/if}

									{if $event.is_monetary}

								  <tr>
									<td class="panel combined">
									<h3>{$event.fee_label}</h3>
									</td>
								  </tr>

								  {if $lineItem}
											{foreach from=$lineItem item=value key=priceset}
									{if $value neq 'skip'}

												<tr>
													<td class="panel combined">
									{if $isPrimary}
									  {if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}
															<table>
										<tr>
										  <td colspan="2" {$labelStyle}>
										   {ts 1=$priceset+1}Participant %1{/ts} {$part.$priceset.info}
										  </td>
										</tr>
										</table>
									  {/if}
									{/if}

															<table> {* FIXME: style this table so that it looks like the text version (justification, etc.) *}
																<tr class="header">
																	<td><h6>{ts}Item{/ts}</h6></td>
																	<td><h6>{ts}Qty{/ts}</h6></td>
																	<td><h6>{ts}Each{/ts}</h6></td>
																	{if $dataArray}
																			<td><h6>{ts}SubTotal{/ts}</h6></td>
																			<td><h6>{ts}Tax Rate{/ts}</h6></td>
																			<td><h6>{ts}Tax Amount{/ts}</h6></td>
																	{/if}
																	<td><h6>{ts}Total{/ts}</h6></td>
																	<{if $pricesetFieldsCount }
																		<td><h6>{ts}Total Participants{/ts}</h6></td>
											{/if}
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
																			{$line.qty}
																		</td>
																		<td>
											{$line.unit_price|crmMoney:$currency}
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
																		{/if}
																		<td>
																			{$line.line_total+$line.tax_amount|crmMoney:$currency}
																		</td>
																		{if $pricesetFieldsCount }
											<td {$tdStyle}>
												{$line.participant_count}
											</td>
										  {/if}
																	</tr>
																{/foreach}

																{if $individual}
											<tr {$participantTotal}>
											  <td colspan=3>{ts}Participant Total{/ts}</td>
											  <td colspan=2>{$individual.$priceset.totalAmtWithTax-$individual.$priceset.totalTaxAmt|crmMoney}</td>
											  <td colspan=1>{$individual.$priceset.totalTaxAmt|crmMoney}</td>
											  <td colspan=2>{$individual.$priceset.totalAmtWithTax|crmMoney}</td>
											</tr>
										{/if}
															</table>
													</td>
												</tr>
												{/if}
												{/foreach}

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
											{if $amounts && !$lineItem}
									   {foreach from=$amounts item=amnt key=level}
								  <tr>
									<td>{
										$amnt.amount|crmMoney:$currency} {$amnt.label}
									</td>
								  </tr>
									   {/foreach}
									  {/if}

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
								 </table>
								 </td>
								</tr>


								{if $isPrimary}
								<tr>
									<td class="panel combined">
									<table>
										<tr>
										  <td class="row-header">
										   {ts}Total Amount{/ts}
										  </td>
										  <td>
										   {$totalAmount|crmMoney:$currency} {if $hookDiscount.message}({$hookDiscount.message}){/if}
										  </td>
										</tr>

										{if $pricesetFieldsCount }
										  <tr>
												<td class="row-header">
													{ts}Total Participants{/ts}
												</td>
											<td>
												{assign var="count" value= 0}
												{foreach from=$lineItem item=pcount}
													{assign var="lineItemCount" value=0}
													{if $pcount neq 'skip'}
													  {foreach from=$pcount item=p_count}
														{assign var="lineItemCount" value=$lineItemCount+$p_count.participant_count}
													  {/foreach}
														{if $lineItemCount < 1 }
														  {assign var="lineItemCount" value=1}
														{/if}
														{assign var="count" value=$count+$lineItemCount}
													{/if}
												{/foreach}
												{$count}
											</td>
										  </tr>
										{/if}

										{if $register_date}
												  <tr>
													<td class="row-header">
													  {ts}Registration Date{/ts}
													</td>
													<td>
													 {$register_date|crmDate}
													</td>
												  </tr>
												{/if}

												{if $receive_date}
											<tr>
												<td class="row-header">
												{ts}Transaction Date{/ts}
												</td>
												<td>
												{$receive_date|crmDate}
												</td>
											</tr>
										  {/if}

										  {if $financialTypeName}
											<tr>
												<td class="row-header">
												{ts}Financial Type{/ts}
												</td>
												<td>
												{$financialTypeName}
												</td>
											</tr>
										  {/if}

										  {if $trxn_id}
											<tr>
												<td class="row-header">
												{ts}Transaction #{/ts}
												</td>
												<td>
												{$trxn_id}
												</td>
											</tr>
										  {/if}

										  {if $paidBy}
											<tr>
												<td class="row-header">
													{ts}Paid By{/ts}
												</td>
												<td>
													{$paidBy}
												</td>
											</tr>
										  {/if}

										  {if $checkNumber}
										  <tr>
										   <td class="row-header">
											{ts}Check Number{/ts}
										   </td>
										   <td {$valueStyle}>
											{$checkNumber}
										   </td>
										  </tr>
										{/if}
									  </table>

									{if $contributeMode ne 'notify' and !$isAmountzero and (!$is_pay_later or $isBillingAddressRequiredForPayLater) and !$isOnWaitlist and !$isRequireApproval}
												<h3>{ts}Billing Name and Address{/ts}</h3>
										<table>
										  <tr>
										   <td colspan="2">
											{$billingName}<br />
											{$address|nl2br}
										   </td>
										  </tr>
										</table>
									{/if}

									{if $contributeMode eq 'direct' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}
									  <h3>{ts}Credit Card Information{/ts}</h3>
									  <table>
										  <tr>
										   <td colspan="2">
											{$credit_card_type}<br />
											{$credit_card_number}<br />
											{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:''|crmDate}
										   </td>
										  </tr>
										</table>
									{/if}

									  </td>
									</tr>
									{/if}
								  {/if}

								  {if $customPre}
										{foreach from=$customPre item=customValue key=i}
										<tr>
											<td class="panel combined">
											<h3>{$customPre_grouptitle.$i}</h3>
											<table>
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
											</table>
											</td>
										</tr>
										{/foreach}
									{/if}

									{if $customPost}
										{foreach from=$customPost item=customPos key=j}
										<tr>
										 <td class="panel combined">
											<h3>{$customPost_grouptitle.$j}</h3>
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
										{/foreach}
									{/if}

									{if $customProfile}
										{foreach from=$customProfile.profile item=eachParticipant key=participantID}
										<tr>
										 <td class="panel combined">
											<h3>{ts 1=$participantID+2}Participant %1{/ts}</h3>
											<table>
											{foreach from=$eachParticipant item=eachProfile key=pid}
												<tr>
													<td class="row-header">
														{$customProfile.title.$pid}
													</td>
												</tr>
												{foreach from=$eachProfile item=val key=field}
												 <tr>
														{foreach from=$val item=v key=f}
														<td class="row-header">
															{$field}
														</td>
														<td>
															{$v}
														</td>
													{/foreach}
												 </tr>
												 {/foreach}
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
									  </td>
									</tr>
								  {/foreach}
								{/if}
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
										{ts 1=$event.selfcancelxfer_time}You may transfer your registration to another participant or cancel your registration up to %1 hours before the event.{/ts} {if $totalAmount}{ts}Cancellations are not refundable.{/ts}{/if}<br />
										{capture assign=selfService}{crmURL p='civicrm/event/selfsvcupdate' q="reset=1&pid=`$participant.id`&{contact.checksum}"  h=0 a=1 fe=1}{/capture}
										<a href="{$selfService}">{ts}Click here to transfer or cancel your registration.{/ts}</a>
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
