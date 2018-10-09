<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class facultadBE extends Model
{
    protected $table = 'facultadBE';
    public $timestamps = false;
    protected $fillable = ['nombre_Facu',];
}
