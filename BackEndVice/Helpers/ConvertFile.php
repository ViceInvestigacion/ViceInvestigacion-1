<?php
class ConvertFile
{
    function FileToString($file) {
        $fileAsString = base64_encode(file_get_contents($file));
    }


}




?>

