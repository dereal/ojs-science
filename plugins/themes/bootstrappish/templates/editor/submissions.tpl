{**
 * templates/editor/submissions.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor submissions page(s).
 *
 *}
{strip}
{strip}
{assign var="pageTitle" value="common.queue.long.$pageToDisplay"}
{url|assign:"currentUrl" page="editor"}
{include file="common/header.tpl"}
{/strip}
{/strip}

<ul class="stay">
	<li{if $pageToDisplay == "submissionsUnassigned"} class="current"{/if}><a href="{url op="submissions" path="submissionsUnassigned"}">{translate key="common.queue.short.submissionsUnassigned"}</a></li>
	<li{if $pageToDisplay == "submissionsInReview"} class="current"{/if}><a href="{url op="submissions" path="submissionsInReview"}">{translate key="common.queue.short.submissionsInReview"}</a></li>
	<li{if $pageToDisplay == "submissionsInEditing"} class="current"{/if}><a href="{url op="submissions" path="submissionsInEditing"}">{translate key="common.queue.short.submissionsInEditing"}</a></li>
	<li{if $pageToDisplay == "submissionsArchives"} class="current"{/if}><a href="{url op="submissions" path="submissionsArchives"}">{translate key="common.queue.short.submissionsArchives"}</a></li>
</ul>

<div class="col-md-12 mag-innert-left">
	<form role="form" action="#">
		<ul class="list-unstyled">
			<li>{translate key="editor.submissions.assignedTo"}: <div class="form-group"><select name="filterEditor" onchange="location.href='{url|escape:"javascript" path=$pageToDisplay searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField filterEditor="EDITOR" escape=false}'.replace('EDITOR', this.options[this.selectedIndex].value)" size="1" class="form-control">{html_options options=$editorOptions selected=$filterEditor}</select></div></li>
			<li>{translate key="editor.submissions.inSection"}: <div class="form-group"><select name="filterSection" onchange="location.href='{url|escape:"javascript" path=$pageToDisplay searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField filterSection="SECTION_ID" escape=false}'.replace('SECTION_ID', this.options[this.selectedIndex].value)" size="1" class="form-control">{html_options options=$sectionOptions selected=$filterSection}</select></div></li>
		</ul>
	</form>
</div>

{if !$dateFrom}
	{assign var="dateFrom" value="--"}
{/if}

{if !$dateTo}
	{assign var="dateTo" value="--"}
{/if}

<script type="text/javascript">
{literal}
<!--
function sortSearch(heading, direction) {
 	var submitForm = document.getElementById('submit');
	submitForm.sort.value = heading;
	submitForm.sortDirection.value = direction;
	submitForm.submit();
}
// -->
{/literal}
</script>

<div class="col-md-12 mag-innert-left">
	<form role="form" class="form-inline" method="post" id="submit" action="{url op="submissions" path=$pageToDisplay}">
		<input type="hidden" name="sort" value="id"/>
		<input type="hidden" name="sortDirection" value="ASC"/>
		<div class="form-group">
			<select name="searchField" size="1" class="form-control">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		</div>
		<div class="form-group">
			<select name="searchMatch" size="1" class="form-control">
				<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
				<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
				<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
			</select>
		</div>
		<div class="form-group"><input type="text" size="15" name="search" class="form-control" value="{$search|escape}" /></div>
		<div class="form-group">
			<select name="dateSearchField" size="1" class="form-control">
				{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
			</select>
		</div>
		{translate key="common.between"}
		{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"form-control\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
		{translate key="common.and"}
		{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"form-control\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
		<input type="hidden" name="dateToHour" value="23" />
		<input type="hidden" name="dateToMinute" value="59" />
		<input type="hidden" name="dateToSecond" value="59" />
		<input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
	</form>
	&nbsp;
	<br/>
</div>	

{include file="editor/$pageToDisplay.tpl"}

{if ($pageToDisplay == "submissionsInReview")}
	<br />
	<div id="notes" class="col-md-12 mag-innert-left">
		<h4>{translate key="common.notes"}</h4>
		<p class="help-block">{translate key="editor.submissionReview.notes"}</p>
	</div>
{elseif ($pageToDisplay == "submissionsInEditing")}
	<br />
	<div id="notes" class="col-md-12 mag-innert-left">
		<h4>{translate key="common.notes"}</h4>
		<p class="help-block">{translate key="editor.submissionEditing.notes"}</p>
	</div>
{/if}

{include file="common/footer.tpl"}