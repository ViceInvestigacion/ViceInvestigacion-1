<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use app\facultadBE;

class facultadController extends Controller
{
    public function index()
    {
        return facultadBE::all();
    }
}
