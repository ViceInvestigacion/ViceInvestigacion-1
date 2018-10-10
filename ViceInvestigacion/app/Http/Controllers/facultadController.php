<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\facultadBE;

class facultadController extends Controller
{
    public function index()
    {
        return facultadBE::all();
        
    }
}
