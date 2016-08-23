<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width"/>
    <link rel="stylesheet" href="http://localhost:8001/sites/all/modules/civicrm/tools/extensions/org.civicrm.transactiontemplates/css/customize.css">
    <link rel="stylesheet" href="http://localhost:8001/sites/all/modules/civicrm/tools/extensions/org.civicrm.transactiontemplates/css/foundation-emails.css">
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
                                                    {if $event.confirm_email_text AND (not $isOnWaitlist AND not $isRequireApproval)}
                                                        <p>{$event.confirm_email_text|htmlize}</p>
                                                    {else}
                                                        <p>Thank you for your participation. This letter is a confirmation that your registration has been received and your status has been updated to
                                                            <strong>{if $participant_status}{$participant_status}{else}{if $isOnWaitlist}waitlisted{else}registered{/if}{/if}</strong>.
                                                        </p>
                                                    {/if}

                                                    {if $isOnWaitlist}
                                                        <p>{ts}You have been added to the WAIT LIST for this event.{/ts}</p>
                                                        {if $isPrimary}
                                                            <p>{ts}If space becomes available you will receive an email with a link to a web page where you can complete your registration.{/ts}</p>
                                                        {/if}
                                                    {elseif $isRequireApproval}
                                                        <p>{ts}Your registration has been submitted.{/ts}</p>
                                                        {if $isPrimary}
                                                            <p>{ts}Once your registration has been reviewed, you will receive an email with a link to a web page
                                                            where you can complete the registration process.{/ts}</p>
                                                        {/if}
                                                    {elseif $is_pay_later && !$isAmountzero && !$isAdditionalParticipant}
                                                        <p>{$pay_later_receipt}</p>
                                                        {* FIXME: this might be text rather than HTML *}
                                                    {else}
                                                        <p>{ts}Please print this confirmation for your records.{/ts}</p>
                                                    {/if}
                                                </td>
                                                <td class="expander"></td>
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
                                                </td>
                                                <td class="expander"></td>
                                            </tr>

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
                                                            {if $event.is_public}
                                                                <tr>
                                                                    <td>
                                                                        {capture assign=icalFeed}{crmURL p='civicrm/event/ical' q="reset=1&id=`$event.id`" h=0 a=1 fe=1}{/capture}
                                                                        <a href="{$icalFeed}">{ts}Download iCalendar File{/ts}</a>
                                                                    </td>
                                                                </tr>
                                                            {/if}
                                                            {if $email}
                                                                <tr>
                                                                    <th>{ts}Registered Email{/ts}</th>
                                                                </tr>
                                                                <tr>
                                                                    <td>{$email}</td>
                                                                </tr>
                                                            {/if}
                                                        </table>
                                                    </td>
                                                    <td class="expander"></td>
                                                </tr>
                                            {/if}

                                            {if $event.is_monetary}
                                            <tr>
                                                <td class="panel combined">
                                                    <h3>{$event.fee_label}</h3>
                                                    <table>
                                                        {if $lineItem}
                                                            {foreach from=$lineItem item=value key=priceset}
                                                                {if $value neq 'skip'}
                                                                    {if $isPrimary}
                                                                        {if $lineItem|@count GT 1} {* Header for multi participant registration cases. *}
                                                                            <tr>
                                                                                <td>{ts 1=$priceset+1}Participant %1{/ts}</td>
                                                                            </tr>
                                                                        {/if}
                                                                    {/if}
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
                                                                        {if $pricesetFieldsCount }
                                                                            <td><h6>{ts}Total Participants{/ts}</h6></td>
                                                                        {/if}
                                                                    </tr>
                                                                    {foreach from=$value item=line}
                                                                        <tr>
                                                                            <td>
                                                                                {if $line.html_type eq 'Text'}{$line.label}{else}{$line.field_title} - {$line.label}{/if}
                                                                                {if $line.description}
                                                                                    <div>{$line.description|truncate:30:"..."}</div>
                                                                                {/if}
                                                                            </td>
                                                                            <td>{$line.qty}</td>
                                                                            <td>{$line.unit_price|crmMoney}</td>
                                                                            {if $dataArray}
                                                                                <td>{$line.unit_price*$line.qty|crmMoney}</td>
                                                                                {if $line.tax_rate != "" || $line.tax_amount != ""}
                                                                                    <td>{$line.tax_rate|string_format:"%.2f"}%</td>
                                                                                    <td>{$line.tax_amount|crmMoney}</td>
                                                                                {else}
                                                                                    <td></td>
                                                                                    <td></td>
                                                                                {/if}
                                                                            {/if}
                                                                            <td>{$line.line_total+$line.tax_amount|crmMoney}</td>
                                                                            {if $pricesetFieldsCount }
                                                                                <td>{$line.participant_count}</td>
                                                                            {/if}
                                                                        </tr>
                                                                    {/foreach}
                                                                {/if}
                                                            {/foreach}
                                                        {/if}
                                                    </table>
                                                </td>
                                                <td class="expander"></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="panel combined">
                                        <table>
                                            {if $lineItem && $dataArray}
                                                <tr>
                                                    <td class="row-header">{ts} Amount Before Tax: {/ts}</td>
                                                    <td>{$totalAmount-$totalTaxAmount|crmMoney}</td>
                                                </tr>
                                                {foreach from=$dataArray item=value key=priceset}
                                                    <tr>
                                                        {if $priceset || $priceset == 0}
                                                            <td>&nbsp;{$taxTerm} {$priceset|string_format:"%.2f"}%</td>
                                                            <td>&nbsp;{$value|crmMoney:$currency}</td>
                                                        {else}
                                                            <td>&nbsp;{ts}No{/ts} {$taxTerm}</td>
                                                            <td>&nbsp;{$value|crmMoney:$currency}</td>
                                                        {/if}
                                                    </tr>
                                                {/foreach}
                                            {/if}
                                            {if $amount && !$lineItem}
                                                {foreach from=$amount item=amnt key=level}
                                                    <tr>
                                                        <td>{$amnt.amount|crmMoney} {$amnt.label}</td>
                                                    </tr>
                                                {/foreach}
                                            {/if}
                                            {if $totalTaxAmount}
                                                <tr>
                                                    <td class="row-header">{ts}Total Tax Amount{/ts}</td>
                                                    <td>{$totalTaxAmount|crmMoney:$currency}</td>
                                                </tr>
                                            {/if}
                                            {if $isPrimary}
                                                <tr>
                                                    <td class="row-header">
                                                        {if $balanceAmount}{ts}Total Paid{/ts}
                                                        {else}{ts}Total Amount{/ts}{/if}
                                                    </td>
                                                    <td>{$totalAmount|crmMoney} {if $hookDiscount.message}({$hookDiscount.message}){/if}</td>
                                                </tr>
                                                {if $balanceAmount}
                                                    <tr>
                                                        <td class="row-header">{ts}Balance{/ts}</td>
                                                        <td>{$balanceAmount|crmMoney}</td>
                                                    </tr>
                                                {/if}
                                                {if $pricesetFieldsCount }
                                                    {assign var="count" value= 0}
                                                    {foreach from=$lineItem item=pcount}
                                                        {assign var="lineItemCount" value=0}
                                                        {if $pcount neq 'skip'}
                                                            {foreach from=$pcount item=p_count}
                                                                {assign var="lineItemCount" value=$lineItemCount+$p_count.participant_count}
                                                            {/foreach}
                                                            {if $lineItemCount lt 1 }
                                                                {assign var="lineItemCount" value=1}
                                                            {/if}
                                                            {assign var="count" value=$count+$lineItemCount}
                                                        {/if}
                                                    {/foreach}
                                                    <tr>
                                                        <td class="row-header">{ts}Total Participants{/ts}</td>
                                                        <td>{$count}</td>
                                                    </tr>
                                                {/if}
                                                {if $is_pay_later}
                                                    <tr>
                                                        <td>
                                                            {$pay_later_receipt}
                                                        </td>
                                                    </tr>
                                                {/if}

                                                {if $register_date}
                                                    <tr>
                                                        <td class="row-header">{ts}Registration Date{/ts}</td>
                                                        <td>{$register_date|crmDate}</td>
                                                    </tr>
                                                {/if}

                                                {if $receive_date}
                                                    <tr>
                                                        <td class="row-header">{ts}Transaction Date{/ts}</td>
                                                        <td>{$receive_date|crmDate}</td>
                                                    </tr>
                                                {/if}

                                                {if $contributionTypeName}
                                                    <tr>
                                                        <td class="row-header">{ts}Financial Type{/ts}</td>
                                                        <td>{$contributionTypeName}</td>
                                                    </tr>
                                                {/if}

                                                {if $trxn_id}
                                                    <tr>
                                                        <td class="row-header">{ts}Transaction #{/ts}</td>
                                                        <td>{$trxn_id}</td>
                                                    </tr>
                                                {/if}

                                                {if $paidBy}
                                                    <tr>
                                                        <td class="row-header">{ts}Paid By{/ts}</td>
                                                        <td>{$paidBy}</td>
                                                    </tr>
                                                {/if}

                                                {if $checkNumber}
                                                    <tr>
                                                        <td class="row-header">{ts}Check Number{/ts}</td>
                                                        <td>{$checkNumber}</td>
                                                    </tr>
                                                {/if}
                                            {/if}
                                        </table>
                                    </td>
                                </tr>
                                {if $contributeMode ne 'notify' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}
                                    <tr>
                                        <td class="panel combined">
                                            <h3>{ts}Billing Name and Address{/ts}</h3>
                                            <table>
                                                <tr>
                                                    <td>{$billingName}</td>
                                                </tr>
                                                <tr>
                                                    <td>{$address|nl2br}</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                {/if}
                                {if $contributeMode eq 'direct' and !$isAmountzero and !$is_pay_later and !$isOnWaitlist and !$isRequireApproval}
                                    <tr>
                                        <td class="panel combined">
                                            <h3>{ts}Credit Card Information{/ts}</h3>
                                            <table>
                                                <tr>
                                                    <td>{$credit_card_type}</td>
                                                    <td>{$credit_card_number}</td>
                                                    <td>{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:''|crmDate}</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                {/if}
                                {/if} {* End of conditional section for Paid events *}

                                {if $customPre}
                                    <tr>
                                        <td class="panel combined">
                                            <h3>{$customPre_grouptitle}</h3>
                                            <table>
                                                {foreach from=$customPre item=value key=customName}
                                                    {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}
                                                        <tr>
                                                            <td class="row-header">{$customName}</td>
                                                            <td>{$value}</td>
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
                                                {foreach from=$customPost item=value key=customName}
                                                    {if ( $trackingFields and ! in_array( $customName, $trackingFields ) ) or ! $trackingFields}
                                                        <tr>
                                                            <td class="row-header">{$customName}</td>
                                                            <td>{$value}</td>
                                                        </tr>
                                                    {/if}
                                                {/foreach}
                                            </table>
                                        </td>
                                    </tr>
                                {/if}

                                {if $customProfile}
                                    {foreach from=$customProfile item=value key=customName}
                                        <tr>
                                            <td class="panel combined">
                                                <h3>{ts 1=$customName+1}Participant Information - Participant %1{/ts}</h3>
                                                <table>
                                                    {foreach from=$value item=val key=field}
                                                        {if $field eq 'additionalCustomPre' or $field eq 'additionalCustomPost'}
                                                            <tr>
                                                                <td>
                                                                    {if $field eq 'additionalCustomPre'}
                                                                        {$additionalCustomPre_grouptitle}
                                                                    {else}
                                                                        {$additionalCustomPost_grouptitle}
                                                                    {/if}
                                                                </td>
                                                            </tr>
                                                            {foreach from=$val item=v key=f}
                                                                <tr>
                                                                    <td class="row-header">{$f}</td>
                                                                    <td>{$v}</td>
                                                                </tr>
                                                            {/foreach}
                                                        {/if}
                                                    {/foreach}
                                                </table>
                                            </td>
                                        </tr>
                                    {/foreach}
                                {/if}
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
