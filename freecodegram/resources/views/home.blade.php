@extends('layouts.app')

@section('content')
<div class="container">
   <div class="row">
   <div class="col-3 p-5">
    <img src="https://cdn.changelog.com/uploads/icons/news_sources/Qo/icon_large.png?v=63680075631" alt="" class="rounded-circle" style="max-height:200px">
   </div>
   <div class="col-9 pt-5">
   <div><h1> <?$user?> </h1></div>
   <div>
   </div>
   <div class="d-flex">
    <div class="pr-5"><strong>3</strong> Posts</div>
    <div class="pr-5"><strong>0</strong> followers</div>
    <div class="pr-4"><strong>0</strong>following</div>
   </div>
   <div class="pt-4 font-weight-bold">Jaysal Patel</div>
   <div>I am a passionate individual in the field IT working everyday to expand my knowledge in the Devops field.</div>
   <div><a href="#"></a> github.com/jaysalpatel</div>
   </div>
   </div>
   <div class="row">
   <div class="col-4"></div>
   <img src="{{url('/github-action2.png')}}" alt="" class="w-100">
   </div>
   <div class="row" >
   <div class="col-4">
   <img src="{{url('/github-actions.png')}}" alt="Image"class="w-150"/>   </div>
</div>
<div class="row">
   <div class="col-4"></div>
   <img src="{{url('/argocd1.png')}}" alt="" class="w-100" >
   </div>
</div>
@endsection
