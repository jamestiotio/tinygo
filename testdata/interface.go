package main

func main() {
	thing := &Thing{"foo"}
	println("thing:", thing.String())
	thing.Print()
	printItf(5)
	printItf(byte('x'))
	printItf("foo")
	printItf(Foo(18))
	printItf(*thing)
	printItf(thing)
	printItf(Stringer(thing))
	printItf(struct{ n int }{})
	printItf(struct {
		n int `foo:"bar"`
	}{})
	printItf(Number(3))
	array := Array([4]uint32{1, 7, 11, 13})
	printItf(array)
	printItf(ArrayStruct{3, array})
	printItf(SmallPair{3, 5})
	s := Stringer(thing)
	println("Stringer.String():", s.String())
	var itf interface{} = s
	println("Stringer.(*Thing).String():", itf.(Stringer).String())

	println("nested switch:", nestedSwitch('v', 3))

	// Try putting a linked list in an interface:
	// https://github.com/tinygo-org/tinygo/issues/309
	itf = linkedList{}

	var n int
	var f float32
	var interfaceEqualTests = []struct {
		equal bool
		lhs   interface{}
		rhs   interface{}
	}{
		{true, true, true},
		{true, int(1), int(1)},
		{true, int8(1), int8(1)},
		{true, int16(1), int16(1)},
		{true, int32(1), int32(1)},
		{true, int64(1), int64(1)},
		{true, uint(1), uint(1)},
		{false, uint(1), uint(2)},
		{true, uint8(1), uint8(1)},
		{true, uint16(1), uint16(1)},
		{true, uint32(1), uint32(1)},
		{true, uint64(1), uint64(1)},
		{true, float32(1.1), float32(1.1)},
		{true, float64(1.1), float64(1.1)},
		{true, complex(100, 8), complex(100, 8)},
		{false, complex(100, 8), complex(101, 8)},
		{false, complex(100, 8), complex(100, 9)},
		{true, complex64(8), complex64(8)},
		{true, complex128(8), complex128(8)},
		{true, "string", "string"},
		{false, "string", "stringx"},
		{true, [2]int16{-5, 201}, [2]int16{-5, 201}},
		{false, [2]int16{-5, 201}, [2]int16{-5, 202}},
		{false, [2]int16{-5, 201}, [2]int16{5, 201}},
		{true, &n, &n},
		{false, &n, new(int)},
		{false, new(int), new(int)},
		{false, &n, &f},
		{true, struct {
			a int
			b int
		}{3, 5}, struct {
			a int
			b int
		}{3, 5}},
		{false, struct {
			a int
			b int
		}{3, 5}, struct {
			a int
			b int
		}{3, 6}},
	}
	for i, tc := range interfaceEqualTests {
		if (tc.lhs == tc.rhs) != tc.equal {
			println("test", i, "of interfaceEqualTests failed")
		}
	}
}

func printItf(val interface{}) {
	switch val := val.(type) {
	case Unmatched:
		panic("matched the unmatchable")
	case Doubler:
		println("is Doubler:", val.Double())
	case Tuple:
		println("is Tuple:", val.Nth(0), val.Nth(1), val.Nth(2), val.Nth(3))
		val.Print()
	case int:
		println("is int:", val)
	case byte:
		println("is byte:", val)
	case string:
		println("is string:", val)
	case Thing:
		println("is Thing:", val.String())
	case *Thing:
		println("is *Thing:", val.String())
	case struct{ i int }:
		println("is struct{i int}")
	case struct{ n int }:
		println("is struct{n int}")
	case struct {
		n int `foo:"bar"`
	}:
		println("is struct{n int `foo:\"bar\"`}")
	case Foo:
		println("is Foo:", val)
	default:
		println("is ?")
	}
}

func nestedSwitch(verb rune, arg interface{}) bool {
	switch verb {
	case 'v', 's':
		switch arg.(type) {
		case int:
			return true
		}
	}
	return false
}

type Thing struct {
	name string
}

func (t Thing) String() string {
	return t.name
}

func (t Thing) Print() {
	println("Thing.Print:", t.name)
}

type Stringer interface {
	String() string
}

type Foo int

type Number int

func (n Number) Double() int {
	return int(n) * 2
}

type Doubler interface {
	Double() int
}

type Tuple interface {
	Nth(int) uint32
	Print()
}

type Array [4]uint32

func (a Array) Nth(n int) uint32 {
	return a[n]
}

func (a Array) Print() {
	println("Array len:", len(a))
}

type ArrayStruct struct {
	n int
	a Array
}

func (a ArrayStruct) Nth(n int) uint32 {
	return a.a[n]
}

func (a ArrayStruct) Print() {
	println("ArrayStruct.Print:", len(a.a), a.n)
}

type SmallPair struct {
	a byte
	b byte
}

func (p SmallPair) Nth(n int) uint32 {
	return uint32(int(p.a)*n + int(p.b)*n)
}

func (p SmallPair) Print() {
	println("SmallPair.Print:", p.a, p.b)
}

// There is no type that matches this method.
type Unmatched interface {
	NeverImplementedMethod()
}

type linkedList struct {
	addr *linkedList
}
