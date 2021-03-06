{**
 * templates/admin/settings.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site settings form.
 *
 *}
{strip}
{assign var="pageTitle" value="admin.siteSettings"}
{include file="common/header.tpl"}
{/strip}

<br/>

<form role="form" id="settings" method="post" action="{url op="saveSettings"}" enctype="multipart/form-data">
	
	{include file="common/formErrors.tpl"}

	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			{if count($formLocales) > 1}
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td colspan="2" width="80%" class="value">
						{url|assign:"settingsUrl" op="settings" escape=false}
						{form_language_chooser form="settings" url=$settingsUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			{/if}
			<tr valign="top">
				<td {if $pageHeaderTitleType[$formLocale] && $pageHeaderTitleImage[$formLocale]}rowspan="4"{else}rowspan="3"{/if} width="20%">{fieldLabel name="title" key="admin.settings.siteTitle" required="true"}</td>
				<td width="15%" class="value">
					<div class="form-group">
						<input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-0" value="0"{if not $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-0" key="manager.setup.useTextTitle"}
					</div>
				</td>
				<td width="65%" class="value">
					<div class="form-group">
						<input type="text" id="title" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" size="40" maxlength="120" class="form-control" />
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td width="20%"><div class="form-group"><input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-1" value="1"{if $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-1" key="manager.setup.useImageTitle"}</div></td>
				<td colspan="2" width="80%" class="value"><div class="form-group"><input type="file" name="pageHeaderTitleImage" class="form-control"/></div> <input type="submit" name="uploadPageHeaderTitleImage" value="{translate key="common.upload"}" class="btn btn-success" /></td>
			</tr>
			<tr valign="top">
				<td colspan="2">
					{if $pageHeaderTitleType[$formLocale] && $pageHeaderTitleImage[$formLocale]}
						{translate key="common.fileName"}: {$pageHeaderTitleImage[$formLocale].originalFilename|escape} {$pageHeaderTitleImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deletePageHeaderTitleImage" value="{translate key="common.delete"}" class="btn btn-danger" />
						<br />
						<img class="img-responsive" src="{$publicFilesDir}/{$pageHeaderTitleImage[$formLocale].uploadName|escape:"url"}" width="{$pageHeaderTitleImage[$formLocale].width|escape}" height="{$pageHeaderTitleImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="admin.settings.homeHeaderImage.altText"}" />
					{/if}
				</td>
			</tr>
			{if $pageHeaderTitleType[$formLocale] && $pageHeaderTitleImage[$formLocale]}
				<tr valign="top">
					<td>{fieldLabel name="pageHeaderTitleImageAltText" key="common.altText"}</td>
					<td colspan="2" width="80%" class="value">
						<div class="form-group"><input type="text" id="pageHeaderTitleImageAltText" name="pageHeaderTitleImageAltText[{$formLocale|escape}]" value="{$pageHeaderTitleImage[$formLocale].altText|escape}" size="40" maxlength="255" class="form-control" /></div>
					</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td colspan="2" class="value"><p class="help-block">{translate key="common.altTextInstructions"}</p></td>
				</tr>
			{/if}
			<tr valign="top">
				<td>{fieldLabel name="intro" key="admin.settings.introduction"}</td>
				<td colspan="2" class="value"><div class="form-group"><textarea name="intro[{$formLocale|escape}]" id="intro" cols="40" rows="10" class="form-control">{$intro[$formLocale]|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="redirect" key="admin.settings.journalRedirect"}</td>
				<td colspan="2" class="value">
					<div class="form-group">
						<select name="redirect" id="redirect" size="1" class="class="form-control"">
							<option value="">{translate key="admin.settings.noJournalRedirect"}</option>
							{html_options options=$redirectOptions selected=$redirect}
						</select>
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td>&nbsp;</td>
				<td colspan="2" class="value"><p class="help-block">{translate key="admin.settings.journalRedirectInstructions"}</p></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="aboutField" key="admin.settings.aboutDescription"}</td>
				<td colspan="2" class="value"><div class="form-group"><textarea name="about[{$formLocale|escape}]" id="aboutField" cols="40" rows="10" class="form-control">{$about[$formLocale]|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="contactName" key="admin.settings.contactName" required="true"}</td>
				<td colspan="2" class="value"><div class="form-group"><input type="text" id="contactName" name="contactName[{$formLocale|escape}]" value="{$contactName[$formLocale]|escape}" size="40" maxlength="90" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="contactEmail" key="admin.settings.contactEmail" required="true"}</td>
				<td colspan="2" class="value"><div class="form-group"><input type="text" id="contactEmail" name="contactEmail[{$formLocale|escape}]" value="{$contactEmail[$formLocale]|escape}" size="40" maxlength="90" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="minPasswordLength" key="admin.settings.minPasswordLength" required="true"}</td>
				<td colspan="2" class="value"><div class="form-group"><input type="text" id="minPasswordLength" name="minPasswordLength" value="{$minPasswordLength|escape}" size="4" maxlength="2" class="form-control" /> {translate key="admin.settings.passwordCharacters"}</div></td>
			</tr>
			<tr>
				<td><label for="journalTheme">{translate key="admin.settings.siteTheme"}</label></td>
				<td colspan="2" class="value">
					<div class="form-group">
						<select name="siteTheme" class="form-control" id="theme"{if empty($themes)} disabled="disabled"{/if}>
								<option value="">{translate key="common.none"}</option>
								{foreach from=$themes key=path item=themePlugin}
									<option value="{$path|escape}"{if $path == $siteTheme} selected="selected"{/if}>{$themePlugin->getDisplayName()|escape}</option>
								{/foreach}
						</select>
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td><label>{translate key="admin.settings.siteStyleSheet"}</label></td>
				<td colspan="2" width="80%" class="value">
					<div class="form-group"><input type="file" name="siteStyleSheet" class="form-control" /><div>
					<br/><input type="submit" name="uploadSiteStyleSheet" value="{translate key="common.upload"}" class="btn btn-success" />
					{if $siteStyleFileExists}
						<br />
						{translate key="common.fileName"}: <a href="{$publicFilesDir}/{$styleFilename}" class="file">{$originalStyleFilename|escape}</a> {$dateStyleFileUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteSiteStyleSheet" value="{translate key="common.delete"}" class="btn btn-danger" />
					{/if}
				</td>
			</tr>
			<tr valign="top">
				<td rowspan="2"><label>{translate key="admin.settings.options"}</label></td>
				<td class="value" colspan="2">
					<div class="form-group">
						<input type="checkbox" id="useAlphalist" name="useAlphalist" {if $useAlphalist}checked="checked" {/if}/>
						{fieldLabel name="useAlphalist" key="admin.settings.useAlphalist"}
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td class="value" colspan="2">
					<div class="form-group">
						<input type="checkbox" id="usePaging" name="usePaging" {if $usePaging}checked="checked" {/if}/>
						{fieldLabel name="usePaging" key="admin.settings.usePaging"}
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td><label>{translate key="admin.settings.journalsList"}</label></td>
				<td colspan="2" class="value">
					<p class="help-block">{translate key="admin.settings.journalsList.description"}</p><br />
					<div class="form-group">
						<input type="checkbox" name="showThumbnail" id="showThumbnail" value="1"{if $showThumbnail} checked="checked"{/if} />
						{fieldLabel name="showThumbnail" key="admin.settings.journalsList.showThumbnail"}<br />
					</div>
					<div class="form-group">
						<input type="checkbox" name="showTitle" id="showTitle" value="1"{if $showTitle} checked="checked"{/if} />
						{fieldLabel name="showTitle" key="admin.settings.journalsList.showTitle"}<br />
					</div>
					<div class="form-group">
						<input type="checkbox" name="showDescription" id="showDescription" value="1"{if $showDescription} checked="checked"{/if} />
						{fieldLabel name="showDescription" key="admin.settings.journalsList.showDescription"}<br />
					</div>
				</td>
			</tr>
		</table>
	</div>

<br />

<div id="oaiRegistration" class="col-md-12 mag-innert-left">
	<h4>{translate key="admin.settings.oaiRegistration"}</h4>

	{url|assign:"oaiUrl" page="oai"}
	{url|assign:"siteUrl" page="index"}
	<p class="help-block">{translate key="admin.settings.oaiRegistrationDescription" siteUrl=$siteUrl oaiUrl=$oaiUrl}</p>
</div>
	
	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="admin" escape=false}'" /></p>
</form>

<p class="help-block">{translate key="common.requiredField"}</p>

{include file="common/footer.tpl"}