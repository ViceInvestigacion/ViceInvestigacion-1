<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function test_BasicTest()
    {
        $response = $this->get('/facultades');

        $response->assertStatus(200);
    }
}
