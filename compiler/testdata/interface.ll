; ModuleID = 'interface.go'
source_filename = "interface.go"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32-unknown-wasi"

%runtime._interface = type { i8*, i8* }
%runtime._string = type { i8*, i32 }

@"reflect/types.type:basic:int" = linkonce_odr constant { i8, i8* } { i8 2, i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:basic:int", i32 0, i32 0) }, align 4
@"reflect/types.type:pointer:basic:int" = linkonce_odr constant { i8, i8* } { i8 21, i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:basic:int", i32 0, i32 0) }, align 4
@"reflect/types.type:pointer:named:error" = linkonce_odr constant { i8, i8* } { i8 21, i8* getelementptr inbounds ({ i8, i8*, i8* }, { i8, i8*, i8* }* @"reflect/types.type:named:error", i32 0, i32 0) }, align 4
@"reflect/types.type:named:error" = linkonce_odr constant { i8, i8*, i8* } { i8 52, i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:named:error", i32 0, i32 0), i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:interface:{Error:func:{}{basic:string}}", i32 0, i32 0) }, align 4
@"reflect/types.type:interface:{Error:func:{}{basic:string}}" = linkonce_odr constant { i8, i8* } { i8 20, i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:interface:{Error:func:{}{basic:string}}", i32 0, i32 0) }, align 4
@"reflect/types.type:pointer:interface:{Error:func:{}{basic:string}}" = linkonce_odr constant { i8, i8* } { i8 21, i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:interface:{Error:func:{}{basic:string}}", i32 0, i32 0) }, align 4
@"reflect/types.type:pointer:interface:{String:func:{}{basic:string}}" = linkonce_odr constant { i8, i8* } { i8 21, i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:interface:{String:func:{}{basic:string}}", i32 0, i32 0) }, align 4
@"reflect/types.type:interface:{String:func:{}{basic:string}}" = linkonce_odr constant { i8, i8* } { i8 20, i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:interface:{String:func:{}{basic:string}}", i32 0, i32 0) }, align 4
@"reflect/types.typeid:basic:int" = external constant i8

declare noalias nonnull i8* @runtime.alloc(i32, i8*, i8*) #0

declare void @runtime.trackPointer(i8* nocapture readonly, i8*) #0

; Function Attrs: nounwind
define hidden void @main.init(i8* %context) unnamed_addr #1 {
entry:
  ret void
}

; Function Attrs: nounwind
define hidden %runtime._interface @main.simpleType(i8* %context) unnamed_addr #1 {
entry:
  call void @runtime.trackPointer(i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:basic:int", i32 0, i32 0), i8* undef) #6
  call void @runtime.trackPointer(i8* null, i8* undef) #6
  ret %runtime._interface { i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:basic:int", i32 0, i32 0), i8* null }
}

; Function Attrs: nounwind
define hidden %runtime._interface @main.pointerType(i8* %context) unnamed_addr #1 {
entry:
  call void @runtime.trackPointer(i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:basic:int", i32 0, i32 0), i8* undef) #6
  call void @runtime.trackPointer(i8* null, i8* undef) #6
  ret %runtime._interface { i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:basic:int", i32 0, i32 0), i8* null }
}

; Function Attrs: nounwind
define hidden %runtime._interface @main.interfaceType(i8* %context) unnamed_addr #1 {
entry:
  call void @runtime.trackPointer(i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:named:error", i32 0, i32 0), i8* undef) #6
  call void @runtime.trackPointer(i8* null, i8* undef) #6
  ret %runtime._interface { i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:named:error", i32 0, i32 0), i8* null }
}

; Function Attrs: nounwind
define hidden %runtime._interface @main.anonymousInterfaceType(i8* %context) unnamed_addr #1 {
entry:
  call void @runtime.trackPointer(i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:interface:{String:func:{}{basic:string}}", i32 0, i32 0), i8* undef) #6
  call void @runtime.trackPointer(i8* null, i8* undef) #6
  ret %runtime._interface { i8* getelementptr inbounds ({ i8, i8* }, { i8, i8* }* @"reflect/types.type:pointer:interface:{String:func:{}{basic:string}}", i32 0, i32 0), i8* null }
}

; Function Attrs: nounwind
define hidden i1 @main.isInt(i8* %itf.typecode, i8* %itf.value, i8* %context) unnamed_addr #1 {
entry:
  %typecode = call i1 @runtime.typeAssert(i8* %itf.typecode, i8* nonnull @"reflect/types.typeid:basic:int", i8* undef) #6
  br i1 %typecode, label %typeassert.ok, label %typeassert.next

typeassert.next:                                  ; preds = %typeassert.ok, %entry
  ret i1 %typecode

typeassert.ok:                                    ; preds = %entry
  br label %typeassert.next
}

declare i1 @runtime.typeAssert(i8*, i8* dereferenceable_or_null(1), i8*) #0

; Function Attrs: nounwind
define hidden i1 @main.isError(i8* %itf.typecode, i8* %itf.value, i8* %context) unnamed_addr #1 {
entry:
  %0 = call i1 @"interface:{Error:func:{}{basic:string}}.$typeassert"(i8* %itf.typecode) #6
  br i1 %0, label %typeassert.ok, label %typeassert.next

typeassert.next:                                  ; preds = %typeassert.ok, %entry
  ret i1 %0

typeassert.ok:                                    ; preds = %entry
  br label %typeassert.next
}

declare i1 @"interface:{Error:func:{}{basic:string}}.$typeassert"(i8*) #2

; Function Attrs: nounwind
define hidden i1 @main.isStringer(i8* %itf.typecode, i8* %itf.value, i8* %context) unnamed_addr #1 {
entry:
  %0 = call i1 @"interface:{String:func:{}{basic:string}}.$typeassert"(i8* %itf.typecode) #6
  br i1 %0, label %typeassert.ok, label %typeassert.next

typeassert.next:                                  ; preds = %typeassert.ok, %entry
  ret i1 %0

typeassert.ok:                                    ; preds = %entry
  br label %typeassert.next
}

declare i1 @"interface:{String:func:{}{basic:string}}.$typeassert"(i8*) #3

; Function Attrs: nounwind
define hidden i8 @main.callFooMethod(i8* %itf.typecode, i8* %itf.value, i8* %context) unnamed_addr #1 {
entry:
  %0 = call i8 @"interface:{String:func:{}{basic:string},main.foo:func:{basic:int}{basic:uint8}}.foo$invoke"(i8* %itf.value, i32 3, i8* %itf.typecode, i8* undef) #6
  ret i8 %0
}

declare i8 @"interface:{String:func:{}{basic:string},main.foo:func:{basic:int}{basic:uint8}}.foo$invoke"(i8*, i32, i8*, i8*) #4

; Function Attrs: nounwind
define hidden %runtime._string @main.callErrorMethod(i8* %itf.typecode, i8* %itf.value, i8* %context) unnamed_addr #1 {
entry:
  %0 = call %runtime._string @"interface:{Error:func:{}{basic:string}}.Error$invoke"(i8* %itf.value, i8* %itf.typecode, i8* undef) #6
  %1 = extractvalue %runtime._string %0, 0
  call void @runtime.trackPointer(i8* %1, i8* undef) #6
  ret %runtime._string %0
}

declare %runtime._string @"interface:{Error:func:{}{basic:string}}.Error$invoke"(i8*, i8*, i8*) #5

attributes #0 = { "target-features"="+bulk-memory,+nontrapping-fptoint,+sign-ext" }
attributes #1 = { nounwind "target-features"="+bulk-memory,+nontrapping-fptoint,+sign-ext" }
attributes #2 = { "target-features"="+bulk-memory,+nontrapping-fptoint,+sign-ext" "tinygo-methods"="reflect/methods.Error() string" }
attributes #3 = { "target-features"="+bulk-memory,+nontrapping-fptoint,+sign-ext" "tinygo-methods"="reflect/methods.String() string" }
attributes #4 = { "target-features"="+bulk-memory,+nontrapping-fptoint,+sign-ext" "tinygo-invoke"="main.$methods.foo(int) uint8" "tinygo-methods"="reflect/methods.String() string; main.$methods.foo(int) uint8" }
attributes #5 = { "target-features"="+bulk-memory,+nontrapping-fptoint,+sign-ext" "tinygo-invoke"="reflect/methods.Error() string" "tinygo-methods"="reflect/methods.Error() string" }
attributes #6 = { nounwind }
