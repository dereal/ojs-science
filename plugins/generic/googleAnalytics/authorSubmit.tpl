{**
 * plugins/generic/googleAnalytics/authorSubmit.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Google Analytics author submission account information
 *
 *}

<!-- Google Analytics -->
<tr valign="top">
	<td>
		{fieldLabel name="authors-$authorIndex-gs" key="plugins.generic.googleAnalytics.authorAccount"}
	</td>
	<td class="value">
		<div class="form-group"><input type="text" name="authors[{$authorIndex|escape}][gs]" id="authors-{$authorIndex|escape}-gs" value="{$author.gs|escape}" size="30" maxlength="90" class="form-control" /></div><br/>
		<span class="help-block">{translate key="plugins.generic.googleAnalytics.authorAccount.description"}</span>
	</td>
</tr>
<!-- /Google Analytics -->