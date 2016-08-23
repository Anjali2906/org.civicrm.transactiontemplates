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
													<p>{ts 1=$displayName}Dear %1{/ts},</p>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>

							{if $recur_txnType eq 'START'}
                                <table class="row">
                                    <tr>
                                        <td class="wrapper last">
                                            <table class="twelve columns">

                                             {if $auto_renew_membership}
                                              <tr>
                                                <td class="text-pad">
                                                 <p>{ts}Thanks for your auto renew membership sign-up.{/ts}</p>
                                                 <p>{ts 1=$recur_frequency_interval 2=$recur_frequency_unit}
                                                 This membership will be automatically renewed every %1 %2(s). {/ts}</p>
                                                </td>
                                              </tr>
                                              <tr>
                                                <td class="text-pad">
                                                    {ts 1=$cancelSubscriptionUrl}
                                                    This membership will be renewed automatically. You can cancel the auto-renewal option by <a href="%1">visiting this web page</a>.{/ts}
                                                </td>
                                              </tr>
                                              <tr>
                                                <td class="text-pad">
                                                    {ts 1=$updateSubscriptionBillingUrl}
                                                    You can update billing details for this automatically renewed membership by <a href="%1">visiting this web page</a>.{/ts}
                                                </td>
                                              </tr>
                                             {else}
                                              <tr>
                                                <td class="text-pad">
                                                    <p>{ts}Thanks for your recurring contribution sign-up.{/ts}</p>
                                                    <p>{ts 1=$recur_frequency_interval 2=$recur_frequency_unit}
                                                    This recurring contribution will be automatically processed every %1 %2(s){/ts}
                                                    {if $recur_installments }{ts 1=$recur_installments}
                                                        for a total of %1 installment(s){/ts}
                                                    {/if}.</p>
                                                    <p>{ts}Start Date{/ts}: {$recur_start_date|crmDate}</p>
                                                </td>
                                              </tr>
                                              <tr>
                                                <td class="text-pad">
                                                    {ts 1=$cancelSubscriptionUrl} You can cancel the recurring contribution option by <a href="%1">visiting this web page</a>.{/ts}
                                                </td>
                                              </tr>
                                              <tr>
                                                <td class="text-pad">
                                                    {ts 1=$updateSubscriptionBillingUrl}You can update billing details for this recurring contribution by <a href="%1">visiting this web page</a>.{/ts}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="text-pad">
                                                        {ts 1=$updateSubscriptionUrl}You can update recurring contribution amount or change the number of installments details for this recurring contribution by <a href="%1">visiting this web page</a>.{/ts}
                                                </td>
                                              </tr>
                                             {/if}
                                            </table>
                                        </td>
                                    </tr>
                                </table>

							{elseif $recur_txnType eq 'END'}
                                <table class="row">
                                    <tr>
                                        <td class="wrapper last">
                                            <table class="twelve columns">
                                            {if $auto_renew_membership}
                                            <tr>
                                                <td class="textpad">
                                                    <p>{ts}Your auto renew membership sign-up has ended and your membership will not be automatically renewed.{/ts}</p>
                                                  </td>
                                              </tr>
                                                {else}
                                              <tr>
                                                <td class="text pad">
                                                    <p>{ts}Your recurring contribution term has ended.{/ts}</p>
                                                    <p>{ts 1=$recur_installments}You have successfully completed %1 recurring contributions. Thank you for your support.{/ts}</p>
                                                </td>
                                              </tr>
                                              <tr>
                                                  <td class="panel empty"></td>
                                                  <td class="expander"></td>
                                              </tr>
                                              <tr>
                                                    <td class="panel combined">
                                                    <h3>{ts 1=$recur_installments}Interval of Subscription for %1 installment(s){/ts}</h3>
                                                    <table>
                                                        <tr>
                                                            <td class="row-header">
                                                                {ts}Start Date{/ts}
                                                            </td>
                                                            <td>
                                                                {$recur_start_date|crmDate}
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                             <td class="row-header">
                                                                  {ts}End Date{/ts}
                                                             </td>
                                                             <td>
                                                                  {$recur_end_date|crmDate}
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
                            {/if}

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
