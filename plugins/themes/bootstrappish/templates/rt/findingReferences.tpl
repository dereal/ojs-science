{**
 * templates/rt/findingReferences.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article reading tools -- "finding references" page.
 *
 *}
{strip}
{assign var=pageTitle value="rt.findingReferences"}
{include file="rt/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--

function invokeGoogleScholar() {
	var googleScholarForm = document.getElementById('googleScholar');

	googleScholarForm.as_q.value = document.getElementById('inputForm').title.value;
	googleScholarForm.as_sauthors.value = document.getElementById('inputForm').author.value;
	googleScholarForm.submit();
}

function invokeWLA() {
	var wlaForm = document.getElementById('wla');
	wlaForm.q.value = document.getElementById('inputForm').title.value + " " + document.getElementById('inputForm').author.value;
	wlaForm.submit();
}

// -->
{/literal}
</script>

<h3>{$article->getLocalizedTitle()|strip_unsafe_html}</h3>

<!-- Include the real forms for each of the search engines -->
<form role="form" id="googleScholar" method="get" action="http://scholar.google.com/scholar">
	<input type="hidden" name="as_q" value="" />
	<input type="hidden" name="as_sauthors" value="" />
	<input type="hidden" name="btnG" value="Search Scholar" />
	<input type="hidden" name="as_occt" value="any" />
	<input type="hidden" name="as_allsubj" value="all" />
</form>

<form role="form" id="wla" method="get" action="http://search.live.com/results.aspx">
	<input type="hidden" name="q" value="" />
	<input type="hidden" name="scope" value="academic" />
</form>

<form role="form" id="inputForm" target="#">
	<!-- Display the form fields -->
	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr valign="top">
				<td width="20%"><label class="control-label" for="author">{translate key="user.role.author"}</label></td>
				<td class="value" width="80%"><div class="form-group"><input name="author" id="author" type="text" size="20" maxlength="40" class="form-control" value="{$article->getAuthorString()|escape}" /></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="title">{translate key="article.title"}</label></td>
				<td class="value"><div class="form-group"><input type="text" id="title" name="title" size="40" maxlength="40" class="form-control" value="{$article->getLocalizedTitle()|escape}" /></div></td>
			</tr>
		</table>
	</div>

	<!-- Display the search engine options -->
	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr valign="top">
				<td width="10%"><input value="{translate key="common.search"}" type="button" onclick="invokeGoogleScholar()" class="btn btn-info" /></td>
				<td width="2%">1.</td>
				<td width="88%">{translate key="rt.findingReferences.googleScholar"}</td>
			</tr>
			<tr valign="top">
				<td><input value="{translate key="common.search"}" type="button" onclick="invokeWLA()" class="btn btn-info" /></td>
				<td>2.</td>
				<td>{translate key="rt.findingReferences.windowsLiveAcademic"}</td>
			</tr>
		</table>
	</div>
</form>

{include file="rt/footer.tpl"}