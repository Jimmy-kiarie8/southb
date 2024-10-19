<div class="from-group">
    <div class="form-group">
        <label for="location_from">Location From<span class="text-danger">*</span></label>
        <select class="form-control" name="location_from" id="location_from" required   wire:change="selectLocation($event.target.value)">
                <option value="">Select</option>
                @foreach(\Modules\Branch\Entities\Branch::all() as $location)
                <option value="{{ $location->id }}">{{ $location->name }}</option>
            @endforeach
        </select>
    </div>
</div>
