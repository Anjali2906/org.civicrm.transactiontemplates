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
											<td class="text-pad header">
													<a href="sample/"><img width="150" height="52" src="https://civicrm.org/sites/default/files/civicrm/custom/images/civicrm-logo-transparent.png" alt="Logo"></a>
											</td>
											<td class="date text-pad header"> {% now "SHORT_DATE_FORMAT" %} </td>
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
									<h3>{ts}INVOICE{/ts}</h3>
									<table>
										<tr>
											<td class="text-pad">										
												<img src = "{$resourceBase}/i/civi99.png" height = "34px" width = "99px">
											</td>
										</tr>
										<tr class="header">
							        <td colspan = "1"></td>
							        <td><h6>{ts}Invoice Date:{/ts}</h6></td>
							        <td><h6>{$domain_organization}</h6></td>
							      </tr>
							      <tr>
							         {if $organization_name}
							            <td>{$display_name}  ({$organization_name})</td>
							         {else}
							           <td>{$display_name}</td>
							         {/if}
							         
							         <td>{$invoice_date}</td>
							        <td>
							          {if $domain_street_address }
							            {$domain_street_address}
							          {/if}
							          {if $domain_supplemental_address_1 }{$domain_supplemental_address_1}{/if}
							        </td>
							      </tr>
							      <tr>
						          <td>{$street_address}   {$supplemental_address_1}</td>
						          <td>{ts}Invoice Number:{/ts}</td>
						          <td>
						            {if $domain_supplemental_address_2 }
						              {$domain_supplemental_address_2}
						            {/if}
						            {if $domain_state }
						              {$domain_state}
						            {/if}
						          </td>
							      </tr>
							      <tr>
							          <td>{$supplemental_address_2}  {$stateProvinceAbbreviation}</td>
							          <td>{$invoice_id}</td>
							          <td>
							            {if $domain_city}
							              {$domain_city}
							            {/if}
							            {if $domain_postal_code }
							              {$domain_postal_code}
							            {/if}
							          </td>
							      </tr>
							      <tr>
							          <td>{$city}  {$postal_code}</td>
							          <td>{ts}Reference:{/ts}</b></td>
							          <td> 
							          	{if $domain_country}
							          		{$domain_country}
							            {/if}
							          </td>
							      </tr>
							      <tr>
							        <td></td>
							        <td>{$source}</td>
							        <td> {if $domain_phone}{$domain_phone}{/if} </td>
							      </tr>
							      <tr>
							        <td></td>
							        <td></td>
							        <td> {if $domain_email}{$domain_email}{/if} </td>
							      </tr>
									</table>
								</td>
							</tr>

							<tr>
								<td class="panel combined">
									<table>
										<tr class="header">
			                <td><h6>{ts}Description{/ts}</h6></td>
			                <td><h6>{ts}Quantity{/ts}</h6></td>
			                <td><h6>{ts}Unit Price{/ts}</h6></td>
			                <td><h6>{$taxTerm} </h6></td>
			                <td><h6>{ts 1=$defaultCurrency}Amount %1{/ts}</h6></td>
			              </tr>

			              {foreach from=$lineItem item=value key=priceset name=taxpricevalue}
			                <tr>
			                  <td>
			                    {if $value.html_type eq 'Text'}
			                    	{$value.label}
			                    {else}
			                    	{$value.field_title} - {$value.label}
			                    {/if} 
			                    {if $value.description}
			                    	<div>{$value.description|truncate:30:"..."}</div>
			                    {/if}
			                  </td>
			                  <td> {$value.qty} </td>
			                  <td> {$value.unit_price|crmMoney:$currency}</td>
			                  {if $value.tax_amount != ''}
			                    <td> {$value.tax_rate}%</td>
			                  {else}
			                    <td>{ts 1=$taxTerm}No %1{/ts}</td>
			                  {/if}
			                  <td>{$value.subTotal|crmMoney:$currency}</td>
			                </tr>
			              {/foreach}

			              <tr>
			                <td colspan = "3"></td>
			                <td>{ts}Sub Total{/ts}</td>
			                <td>{$subTotal|crmMoney:$currency}</td>
			              </tr>
			              {foreach from = $dataArray item = value key = priceset}
			                <tr>
			                  <td colspan = "3"></td>
			                  {if $priceset}
			                    <td> {ts 1=$taxTerm 2=$priceset}TOTAL %1 %2%{/ts}</td>
			                    <td>{$value|crmMoney:$currency} </td>
			                  {elseif $priceset == 0}
			                    <td>{ts 1=$taxTerm}TOTAL NO %1{/ts}</td>
			                    <td>{$value|crmMoney:$currency}</td>
			                  {/if}
			                </tr>
			              {/foreach}

			              <tr>
			                <td colspan = "3"></td>
			                <td colspan = "2"><hr></hr></td>
			              </tr>

			              <tr>
			                <td colspan = "3"></td>
			                <td class="row-header">{ts 1=$defaultCurrency}TOTAL %1{/ts}</td>
			                <td>{$amount|crmMoney:$currency}</td>
			              </tr>

			              {if $is_pay_later == 0}
			                <tr>
			                  <td colspan = "3"></td>
			                  <td>
			                     {if $contribution_status_id == $refundedStatusId}
			                    {ts}LESS Amount Credited{/ts}
			                     {else}
			                    {ts}LESS Amount Paid{/ts}
			                     {/if}
			                  </td>
			                  <td>{$amount|crmMoney:$currency}</td>
			                </tr>
			                <tr>
			                  <td colspan = "3"></td>
			                  <td colspan = "2" ><hr></hr></td>
			                </tr>
			                <tr>
			                  <td colspan = "3"></td>
			                  <td class="row-header">{ts}AMOUNT DUE:{/ts} </td>
			                  <td class="row-header">{$amountDue|crmMoney:$currency}</td>   
			                  <td></td>
			                </tr>
			              {/if}

			              <tr>
			                <td colspan = "3"></td>
			              </tr>
			              {if $contribution_status_id == $pendingStatusId && $is_pay_later == 1}
			                <tr>
			                  <td class="row-header">{ts 1=$dueDate}DUE DATE: %1{/ts}</td>
			                  <td colspan = "3"></td>
			                </tr>
			              {/if}

									</table>
								</td>
							</tr>

							{if $contribution_status_id == $pendingStatusId && $is_pay_later == 1}

							 	<tr>
								 	<td class="panel combined">
								 		<h3>{ts}PAYMENT ADVICE{/ts}</h3>
										<table>
											<tr>
								        <td><img src = "{$resourceBase}/i/contribute/cut_line.png" height = "15" width = "630"></td>
								      </tr>
											<tr>
								        <td>
								          <strong>{ts}To: {/ts}</strong>      
								          <div style="width:17em;word-wrap:break-word;">
								            {$domain_organization} <br />
								            {$domain_street_address} {$domain_supplemental_address_1} <br />
								            {$domain_supplemental_address_2} {$domain_state} <br />
								            {$domain_city} {$domain_postal_code} <br />
								            {$domain_country} <br />
								            {$domain_phone} <br />
								            {$domain_email}
								          </div>
								          <br/><br/>{$notes}
								        </td>

								        <td width="50%">
								          <table>
								            <tr>
								              <td colspan = "2"></td>
								              <td class="row-header">{ts}Customer: {/ts}</td>
								              <td> {$display_name}</td>
								            </tr>
								            <tr>
								              <td colspan = "2"></td>
								              <td class="row-header">{ts}Invoice Number: {/ts}</td>
								              <td>{$invoice_id}</td>
								            </tr>
								            <tr><td  colspan = "5"><hr></hr></td></tr>
								            {if $is_pay_later == 1}
								            <tr>
								              <td colspan = "2"></td>
								              <td class="row-header">{ts}Amount Due:{/ts}</td>
								              <td class="row-header">{$amount|crmMoney:$currency}</td>
								            </tr>
								            {else}
								            <tr>
								              <td colspan = "2"></td>
								              <td class="row-header">{ts}Amount Due: {/ts}</td>
								              <td class="row-header">{$amountDue|crmMoney:$currency}</td>
								            </tr>
								            {/if}
								            <tr>
								              <td colspan = "2"></td>
							                <td class="row-header">{ts}Due Date:  {/ts}</td>
							                <td>{$dueDate}</td>
								            </tr>
								            <tr>
								              <td colspan = "5"><hr></hr></td>
								            </tr>
								          </table>
								        </td>
								      </tr>
										</table>
									</td>
								</tr>

								<tr>
								 	<td class="panel combined">
									<h3>{ts}CREDIT NOTE{/ts}</h3>
										<table>
											<tr class="header">
							          <td colspan = "1"></td>
							          <td><h6> {ts}Date:{/ts}</h6></td>
							          <td><h6>{$domain_organization}</h6></td>
							        </tr>
							        <tr>
							          {if $organization_name}
							            <td>{$display_name}  ({$organization_name})</td>
							          {else}
							            <td>{$display_name}</td>
							          {/if}
							          <td>{$invoice_date}</td>
							          <td>
							            {if $domain_street_address }
							              {$domain_street_address}
							            {/if}
							            {if $domain_supplemental_address_1 }
							              {$domain_supplemental_address_1}
							            {/if}
							          </td>
							        </tr>
							        <tr>
							          <td>{$street_address}   {$supplemental_address_1}</td>
							          <td><b>{ts}Credit Note Number:{/ts}</b></td>
							          <td>{
							            if $domain_supplemental_address_2 }
							              {$domain_supplemental_address_2}
							            {/if}
							            {if $domain_state }
							              {$domain_state}
							            {/if}
							          </td>
							        </tr>
							        <tr>
							          <td>{$supplemental_address_2}  {$stateProvinceAbbreviation}</td>
							          <td>{$creditnote_id}</td>
							          <td>
							            {if $domain_city}
							              {$domain_city}
							            {/if}
							            {if $domain_postal_code }
							              {$domain_postal_code}
							            {/if}
							          </td>
							        </tr>
							        <tr>
							          <td>{$city}  {$postal_code}</td>
							          <td><b>{ts}Reference:{/ts}</b></td>
							          <td>
							            {if $domain_country}
							              {$domain_country}
							            {/if}
							          </td>
							        </tr>
							        <tr>
							          <td></td>
							          <td></td>
							          <td><strong>{$source}</strong></td>
							          <td>
							          	{if $domain_phone}
							              {$domain_phone}
							            {/if} 
							          </td>
							        </tr>
							        <tr>
							          <td></td>
							          <td></td>
							          <td></td>
							          <td> {if $domain_email}
							          {$domain_email}
							              {/if} </td>
							        </tr>
										</table>
									</td>
								</tr>

								<tr>
								 	<td class="panel combined">
										<table>
											<tr>
				                <td><h6>{ts}Description{/ts}</h6></td>
				                <td><h6>{ts}Quantity{/ts}</h6></td>
				                <td><h6>{ts}Unit Price{/ts}</h6></td>
				                <td><h6>{$taxTerm} </h6></td>
				                <td><h6>{ts 1=$defaultCurrency}Amount %1{/ts}</h6></td>
				              </tr>
				              {foreach from=$lineItem item=value key=priceset name=pricevalue}
				                <tr>
				                  <td>
				                    {if $value.html_type eq 'Text'}{$value.label}{else}{$value.field_title} - {$value.label}{/if} {if $value.description}<div>{$value.description|truncate:30:"..."}</div>{/if}
				                  </td>
				                  <td> {$value.qty}</td>
				                  <td> {$value.unit_price|crmMoney:$currency}</td>
				                  {if $value.tax_amount != ''}
				                    <td> {$value.tax_rate}%</td>
				                  {else}
				                    <td>{ts 1=$taxTerm}No %1{/ts}</td>
				                  {/if}
				                 <td>{$value.subTotal|crmMoney:$currency}</td>
					              </tr>
					            {/foreach}

						          <tr>
						          	<td colspan="5"><hr></hr></td>
						          </tr>
						          <tr>
						            <td colspan = "3"></td>
						            <td class="row-header">{ts}Sub Total{/ts}</td>
						            <td>{$subTotal|crmMoney:$currency}</td>
						          </tr>
						          {foreach from = $dataArray item = value key = priceset}
						            <tr>
						              <td colspan = "3"></td>
						              {if $priceset}
						                <td class="row-header"> {ts 1=$taxTerm 2=$priceset}TOTAL %1 %2%{/ts}</td>
						                <td>{$value|crmMoney:$currency} </td>
						              {elseif $priceset == 0}
						                <td>{ts 1=$taxTerm}TOTAL NO %1{/ts}</td>
						                <td>{$value|crmMoney:$currency} </td>
						              {/if}
						            </tr>
						          {/foreach}
						          <tr>
						            <td colspan = "3"></td>
						            <td colspan = "2"><hr></hr></td>
						          </tr>

						          <tr>
						            <td colspan = "3"></td>
						            <td class="row-header">{ts 1=$defaultCurrency}TOTAL %1{/ts}</td>
						            <td>{$amount|crmMoney:$currency}</td>
						          </tr>

				          	{if $is_pay_later == 0}
		                  <tr>
					              <td colspan = "3"></td>
					              <td>{ts}LESS Credit to invoice(s){/ts}</td>
					              <td>{$amount|crmMoney:$currency}</td>
					            </tr>
					            <tr>
					              <td colspan = "3"></td>
					              <td colspan = "2" ><hr></hr></td>
					            </tr>
					            <tr>
					              <td colspan = "3"></td>
					              <td class="row-header">{ts}REMAINING CREDIT{/ts}</td>
					              <td class="row-header">{$amountDue|crmMoney:$currency}</td>
					              <td></fonts></td>
					            </tr>
					          {/if}
					          <br/><br/><br/>
					          <tr>
					            <td colspan = "3"></td>
					          </tr>
					          <tr>
					            <td></td>
					            <td colspan = "3"></td>
					          </tr>
										</table>
									</td>
								</tr>

								<tr>
								 	<td class="panel combined">
									<h3>{ts}CREDIT ADVICE{/ts}</h3>
										<table>
											<tr>
									      <td><img src = "{$resourceBase}/i/contribute/cut_line.png" height = "15" width = "630"></td>
									    </tr>
									    <tr>
								        <td></b><br/><br />
								          <div style="font-size:10px;max-width:300px;">
								            {ts}Please do not pay on this advice. Deduct the amount of this Credit Note from your next payment to us{/ts}
								          </div><br/>
								        </td>
								        <td width="40%">
								          <table>
								            <tr>
								              <td colspan = "2"></td>
								              <td>{ts}Customer:{/ts} </td>
								              <td>{$display_name}</td>
								            </tr>
								            <tr>
								              <td colspan = "2"></td>
								              <td>{ts}Credit Note#:{/ts} </td>
								              <td>{$creditnote_id}</td>
								            </tr>
								            <tr><td colspan = "5"><hr></hr></td></tr>
								            <tr>
								              <td colspan = "2"></td>
								              <td>{ts}Credit Amount:{/ts}</td>
								              <td>{$amount|crmMoney:$currency}</td>
								            </tr>
								          </table>
								        </td>
								      </tr>

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
