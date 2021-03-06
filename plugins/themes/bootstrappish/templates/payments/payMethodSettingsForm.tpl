{**
 * templates/payments/payMethodSettingsForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to edit payment settings.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.payment.paymentMethods"}
{include file="common/header.tpl"}
{/strip}

<ul class="stay">
	<li><a href="{url op="payments"}">{translate key="manager.payment.options"}</a></li>
	<li class="current"><a href="{url op="payMethodSettings"}">{translate key="manager.payment.paymentMethods"}</a></li>
	<li><a href="{url op="viewPayments"}">{translate key="manager.payment.records"}</a></li>
</ul>

{include file="common/formErrors.tpl"}

<script type="text/javascript">
{literal}
<!--

function changePaymentMethod() {
	document.getElementById('paymentSettingsForm').action="{/literal}{url|escape:"javascript" op="payMethodSettings" escape=false}{literal}";
		document.getElementById('paymentSettingsForm').submit();
	}

// -->
{/literal}
</script>

<form role="form" method="post" id="paymentSettingsForm" action="{url op="savePayMethodSettings"}">
	<p class="help-block">{translate key="manager.payment.paymentMethod.description"}</p>

	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr valign="top">
				<td class="data" colspan="2">
					{assign var=pluginIndex value=1}
					<h4>{translate key="manager.payment.paymentMethods"}</h4>
					{foreach from=$paymentMethodPlugins item=plugin}
						&nbsp;<div class="form-group"><input type="radio" name="paymentMethodPluginName" id="paymentMethodPluginName-{$pluginIndex|escape}" value="{$plugin->getName()|escape}" onclick="changePaymentMethod();" {if $paymentMethodPluginName == $plugin->getName()}checked="checked" {/if}/>&nbsp;<label class="control-label" for="paymentMethodPluginName-{$pluginIndex|escape}">{$plugin->getDisplayName()|escape}</label></div><br/>
						<p class="help-block">{$plugin->getDescription()}</p>
						{assign var=pluginIndex value=$pluginIndex+1}
					{/foreach}
				</td>
			</tr>
			{call_hook name="Template::Manager::Payment::displayPaymentSettingsForm" plugin=$paymentMethodPluginName}
		</table>
	</div>

	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="manager"}'" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{include file="common/footer.tpl"}