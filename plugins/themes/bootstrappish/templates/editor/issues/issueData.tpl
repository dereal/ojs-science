{**
 * templates/editor/issues/issueData.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for creation and modification of an issue
 *}
{strip}
{assign var="pageTitleTranslated" value=$issue->getIssueIdentification()}
{assign var="pageCrumbTitleTranslated" value=$issue->getIssueIdentification(false,true)}
{include file="common/header.tpl"}
{/strip}

{if !$isLayoutEditor}{* Layout Editors can also access this page. *}
	<ul class="stay">
		<li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
		<li{if $unpublished} class="current"{/if}><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
		<li{if !$unpublished} class="current"{/if}><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
	</ul>
{/if}

<br />

<form role="form" action="#">
	{translate key="issue.issue"}: <div class="form-group"><select name="issue" class="form-control" onchange="if(this.options[this.selectedIndex].value > 0) location.href='{url|escape:"javascript" op="issueToc" path="ISSUE_ID" escape=false}'.replace('ISSUE_ID', this.options[this.selectedIndex].value)" size="1">{html_options options=$issueOptions|truncate:40:"..." selected=$issueId}</select></div>
</form>

<div class="separator"></div>

<ul class="stay">
	<li><a href="{url op="issueToc" path=$issueId}">{translate key="issue.toc"}</a></li>
	<li class="current"><a href="{url op="issueData" path=$issueId}">{translate key="editor.issues.issueData"}</a></li>
	<li><a href="{url op="issueGalleys" path=$issueId}">{translate key="editor.issues.galleys"}</a></li>
	{if $unpublished}<li><a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">{translate key="editor.issues.previewIssue"}</a></li>{/if}
</ul>

<form role="form" id="issue" method="post" action="{url op="editIssue" path=$issueId}" enctype="multipart/form-data">
	<input type="hidden" name="fileName[{$formLocale|escape}]" value="{$fileName[$formLocale]|escape}" />
	<input type="hidden" name="originalFileName[{$formLocale|escape}]" value="{$originalFileName[$formLocale]|escape}" />
	
	{if $styleFileName}
		<input type="hidden" name="styleFileName" value="{$styleFileName|escape}" />
		<input type="hidden" name="originalStyleFileName" value="{$originalStyleFileName|escape}" />
	{/if}
	
	{include file="common/formErrors.tpl"}
	
	<div id="issueId" class="table-responsive">
		<h3>{translate key="editor.issues.identification"}</h3>
		<table width="100%" class="table table-striped">
			{if count($formLocales) > 1}
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{url|assign:"issueUrl" op="issueData" path=$issueId escape=false}
						{form_language_chooser form="issue" url=$issueUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			{/if}
			<tr valign="top">
				<td width="20%">{fieldLabel name="volume" key="issue.volume"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="text" name="volume" id="volume" value="{$volume|escape}" size="5" maxlength="5" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="number" key="issue.number"}</td>
				<td class="value"><div class="form-group"><input type="text" name="number" id="number" value="{$number|escape}" size="5" maxlength="10" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="year" key="issue.year"}</td>
				<td class="value"><div class="form-group"><input type="text" name="year" id="year" value="{$year|escape}" size="5" maxlength="4" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="labelFormat" key="editor.issues.issueIdentification"}</td>
				<td class="value"><div class="form-group"><input type="checkbox" name="showVolume" id="showVolume" value="1"{if $showVolume} checked="checked"{/if} /><label class="control-label" for="showVolume"> {translate key="issue.volume"}</label></div><br /><div class="form-group"><input type="checkbox" name="showNumber" id="showNumber" value="1"{if $showNumber} checked="checked"{/if} /><label class="control-label" for="showNumber"> {translate key="issue.number"}</label></div><br /><div class="form-group"><input type="checkbox" name="showYear" id="showYear" value="1"{if $showYear} checked="checked"{/if} /><label class="control-label" for="showYear"> {translate key="issue.year"}</label></div><br /><div class="form-group"><input type="checkbox" name="showTitle" id="showTitle" value="1"{if $showTitle} checked="checked"{/if} /><label class="control-label" for="showTitle"> {translate key="issue.title"}</label></div></td>
			</tr>
			{if $enablePublicIssueId}
				<tr valign="top">
					<td>{fieldLabel name="publicIssueId" key="editor.issues.publicIssueIdentifier"}</td>
					<td class="value"><div class="form-group"><input type="text" name="publicIssueId" id="publicIssueId" value="{$publicIssueId|escape}" size="20" maxlength="255" class="form-control" /></div></td>
				</tr>
			{/if}
			<tr valign="top">
				<td>{fieldLabel name="title" key="issue.title"}</td>
				<td class="value"><div class="form-group"><input type="text" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="40" maxlength="120" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="description" key="editor.issues.description"}</td>
				<td class="value"><div class="form-group"><textarea name="description[{$formLocale|escape}]" id="description" cols="40" rows="5" class="form-control">{$description[$formLocale]|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td>{translate key="common.status"}</td>
				<td class="value">
					{if $issue->getPublished()}
						{translate key="editor.issues.published"}&nbsp;&nbsp;
						{* Find good values for starting and ending year options *}
						{assign var=currentYear value=$smarty.now|date_format:"%Y"}
						{if $datePublished}
							{assign var=publishedYear value=$datePublished|date_format:"%Y"}
							{math|assign:"minYear" equation="min(x,y)-10" x=$publishedYear y=$currentYear}
							{math|assign:"maxYear" equation="max(x,y)+2" x=$publishedYear y=$currentYear}
						{else}
							{* No issue publication date info *}
							{math|assign:"minYear" equation="x-10" x=$currentYear}
							{math|assign:"maxYear" equation="x+2" x=$currentYear}
						{/if}
						{html_select_date prefix="datePublished" time=$datePublished|default:"---" all_extra="class=\"selectMenu\"" start_year=$minYear end_year=$maxYear year_empty="-" month_empty="-" day_empty="-"}
					{else}
						{translate key="editor.issues.unpublished"}
					{/if}

					{if $issue->getDateNotified()}
						<br/>
						{translate key="editor.usersNotified"}&nbsp;&nbsp;
						{$issue->getDateNotified()|date_format:$dateFormatShort}
					{/if}
				</td>
			</tr>
		</table>
	</div>

	{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
		
		<div class="separator"></div>
		
		<div id="issueAccess" class="table-responsive">
			<h3>{translate key="editor.issues.access"}</h3>
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="accessStatus" key="editor.issues.accessStatus"}</td>
					<td width="80%" class="value"><div class="form-group"><select name="accessStatus" id="accessStatus" class="form-control">{html_options options=$accessOptions selected=$accessStatus}</select></div></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="openAccessDate" key="editor.issues.accessDate"}</td>
					<td class="value">
						<div class="form-group"><input type="checkbox" id="enableOpenAccessDate" name="enableOpenAccessDate" {if $openAccessDate}checked="checked" {/if}onchange="document.getElementById('issue').openAccessDateMonth.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateDay.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateYear.disabled=this.checked?false:true;" />&nbsp;{fieldLabel name="enableOpenAccessDate" key="editor.issues.enableOpenAccessDate"}</div><br/>
						{if $openAccessDate}
							{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"form-control\""}
						{else}
							{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"form-control\" disabled=\"disabled\""}
						{/if}
					</td>
				</tr>
			</table>
		</div>
	{/if}

	<div class="separator"></div>

	{foreach from=$pubIdPlugins item=pubIdPlugin}
		{assign var=pubIdMetadataFile value=$pubIdPlugin->getPubIdMetadataFile()}
		{include file="$pubIdMetadataFile" pubObject=$issue}
	{/foreach}

	{call_hook name="Templates::Editor::Issues::IssueData::AdditionalMetadata"}

	<div id="issueCover" class="table-responsive">
		<h3>{translate key="editor.issues.cover"}</h3>
		<table width="100%" class="table table-striped">
			<tr valign="top">
				<td colspan="2"><div class="form-group"><input type="checkbox" name="showCoverPage[{$formLocale|escape}]" id="showCoverPage" value="1" {if $showCoverPage[$formLocale]} checked="checked"{/if} /> <label class="control-label" for="showCoverPage">{translate key="editor.issues.showCoverPage"}</label></div></td>
			</tr>
			<tr valign="top">
				<td width="20%">{fieldLabel name="coverPage" key="editor.issues.coverPage"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="file" name="coverPage" id="coverPage" class="form-control" />&nbsp;&nbsp;{translate key="form.saveToUpload"}<br />{translate key="editor.issues.coverPageInstructions"}<br />{translate key="editor.issues.uploaded"}:&nbsp;{if $fileName[$formLocale] }<a href="javascript:openWindow('{$publicFilesDir}/{$fileName[$formLocale]|escape:"url"}');" class="file">{$originalFileName[$formLocale]}</a>&nbsp;<a href="{url op="removeIssueCoverPage" path=$issueId|to_array:$formLocale}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.removeCoverPage"}')">{translate key="editor.issues.remove"}</a>{else}&mdash;{/if}</div></td>
			</tr>
			<tr valign="top">
				<td width="20%">{fieldLabel name="coverPageAltText" key="common.altText"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="text" name="coverPageAltText[{$formLocale|escape}]" value="{$coverPageAltText[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>&nbsp;</td>
				<td class="value"><p class="help-block">{translate key="common.altTextInstructions"}</p></td>
			</tr>
			<tr valign="top">
				<td width="20%">{fieldLabel name="styleFile" key="editor.issues.styleFile"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="file" name="styleFile" id="styleFile" class="form-control" />&nbsp;&nbsp;{translate key="form.saveToUpload"}<br />{translate key="editor.issues.uploaded"}:&nbsp;{if $styleFileName}<a href="javascript:openWindow('{$publicFilesDir}/{$styleFileName|escape}');" class="file">{$originalStyleFileName|escape}</a>&nbsp;<a href="{url op="removeStyleFile" path=$issueId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.removeStyleFile"}')">{translate key="editor.issues.remove"}</a>{else}&mdash;{/if}</div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="coverPageDescription" key="editor.issues.coverPageCaption"}</td>
				<td class="value"><div class="form-group"><textarea name="coverPageDescription[{$formLocale|escape}]" id="coverPageDescription" cols="40" rows="5" class="form-control">{$coverPageDescription[$formLocale]|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td width="20%">{fieldLabel name="hideCoverPageArchives" key="editor.issues.coverPageDisplay"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="checkbox" name="hideCoverPageArchives[{$formLocale|escape}]" id="hideCoverPageArchives" value="1" {if $hideCoverPageArchives[$formLocale]} checked="checked"{/if} /> <label class="control-label" for="hideCoverPageArchives">{translate key="editor.issues.hideCoverPageArchives"}</label></div></td>
			</tr>
			<tr valign="top">
				<td width="20%">&nbsp;</td>
				<td class="value"><div class="form-group"><input type="checkbox" name="hideCoverPageCover[{$formLocale|escape}]" id="hideCoverPageCover" value="1" {if $hideCoverPageCover[$formLocale]} checked="checked"{/if} /> <label class="control-label" for="hideCoverPageCover">{translate key="editor.issues.hideCoverPageCover"}</label></div></td>
			</tr>
		</table>
	</div>
	
	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" onclick="document.location.href='{url op="issueData" path=$issueId escape=false}'" class="btn btn-danger" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{include file="common/footer.tpl"}