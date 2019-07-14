Remove-Item -Path "results\*" -Recurse

foreach ($tool in Get-ChildItem "tools")
{
    Write-Host "`nTesting $tool`n" 
    New-item -Name "results\$($tool.BaseName)" -ItemType directory

    foreach ($image in Get-ChildItem "images")
    {
        if ($tool.BaseName -eq "jpegoptim")
        {
            # m85
            # Copy-Item -Path $image.FullName -Destination "results\$($tool.BaseName)\$($image.BaseName).m85$($image.Extension)"
            # & "tools\$tool" -m85 "results\$($tool.BaseName)\$($image.BaseName).m85$($image.Extension)"

            # m85 strip all
            Copy-Item -Path $image.FullName -Destination "results\$($tool.BaseName)\$($image.BaseName).m85.stripall$($image.Extension)"
            & "tools\$tool" -m85 --strip-all "results\$($tool.BaseName)\$($image.BaseName).m85.stripall$($image.Extension)"

            # m85 strip all progressive
            # Copy-Item -Path $image.FullName -Destination "results\$($tool.BaseName)\$($image.BaseName).m85.stripall.progressive$($image.Extension)"
            # & "tools\$tool" -m85 --strip-all --all-progressive "results\$($tool.BaseName)\$($image.BaseName).m85.stripall.progressive$($image.Extension)"
        }
        
        if ($tool.BaseName -eq "mozcjpeg" -or $tool.BaseName -eq "turbocjpeg")
        {
            # q85
            # & ".\tools\$tool" -quality 85 -outfile "results\$($tool.BaseName)\$($image.BaseName).q85$($image.Extension)" "images\$image"

            # q85
            & ".\tools\$tool" -quality 85 -optimize -outfile "results\$($tool.BaseName)\$($image.BaseName).q85.optimize$($image.Extension)" "images\$image"

            # q85
            # & ".\tools\$tool" -quality 85 -optimize -progressive -outfile "results\$($tool.BaseName)\$($image.BaseName).q85.optimize.progressive$($image.Extension)" "images\$image"
        }

        if ($tool.BaseName -eq "mozjpegtran" -or $tool.BaseName -eq "turbojpegtran")
        {
            # Copy none
            # & ".\tools\$tool" -copy none -outfile "results\$($tool.BaseName)\$($image.BaseName).copynone$($image.Extension)" "images\$image"

            # Copy none optimize
            & ".\tools\$tool" -copy none -optimize -outfile "results\$($tool.BaseName)\$($image.BaseName).copynone.optimize$($image.Extension)" "images\$image"

            # Copy none optimize progressive
            # & ".\tools\$tool" -copy none -optimize -progressive -outfile "results\$($tool.BaseName)\$($image.BaseName).copynone.optimize.progressive$($image.Extension)" "images\$image"
        }
    }
}