%module csharp_swig2_compatibility

%typemap(cscode) Foo %{

// Without the using directives generated by the
// SWIG 2 compatibility mode, this code would fail
// to build.
public void FooBar(string input)
{
  Console.WriteLine(input);
}

%}

%pragma(csharp) imclasscode=%{

// Without the using directives generated by the
// SWIG 2 compatibility mode, this code would fail
// to build.
public void IntermediateClassMethod(string input)
{
  Console.WriteLine(input);
}

%}

%pragma(csharp) modulecode=%{

// Without the using directives generated by the
// SWIG 2 compatibility mode, this code would fail
// to build.
public void ModuleClassMethod(string input)
{
  Console.WriteLine(input);
}

%}

%inline %{
class Foo {
public:
  Foo() {}
  
  void Bar() {}
};

%}
