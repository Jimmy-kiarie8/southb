<?php

namespace Modules\Branch\Http\Controllers;

use App\DataTables\BranchDataTable;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Gate;
use Modules\Branch\Entities\Branch;

class BranchController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(BranchDataTable $dataTable)
    {
        // return view('branch::index');

        abort_if(Gate::denies('access_branches'), 403);

        return $dataTable->render('branch::index');
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('branch::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {

        abort_if(Gate::denies('access_branches'), 403);

        $request->validate([
            'name'     => 'required|string|max:255',
            'location'    => 'required',
        ]);

        Branch::create([
            'name'     => $request->name,
            'location'    => $request->location,
        ]);


        toast("Branch Created", 'success');

        return redirect()->route('branch.index');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('branch::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('branch::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
        //
    }
}
