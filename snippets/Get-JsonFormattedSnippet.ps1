function Get-JsonFormattedSnippet {
	PARAM($data,$lib)
	PROCESS {
		$code = $data.Split('(')[0]
		$vars = $data.Split('(')[1].Split(')')[0].Replace(' ','').Split(',')
		$formattedSnippet = ",`r`n`"$code`": {`r`n`t`"prefix`": `"$code`",`r`n`t`"body`": [`r`n`t`t`"$code`("
		if ($vars.Count -gt 0) {
			$i = 1
			foreach ($var in $vars) {
				if ($var -eq '' -or $var -eq ' ' -or $var -eq $null) { continue }
				$formattedSnippet = $formattedSnippet + "`${$i`:$var}"
				if ($vars.Count -gt $i) {
					$formattedSnippet = $formattedSnippet + ", "
				}
				$i++
			}
		}
		$formattedSnippet = $formattedSnippet + ")`"`r`n`t],`r`n`t`"description`": `"$lib`"`r`n}"
		return $formattedSnippet
	}
}