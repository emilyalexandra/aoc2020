import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.functional;

alias memCountTotal = memoize!countTotal;

void main() {
	string input = cast(string) read("../input.txt");
	int[] arr = input.split("\n")[0..$ - 1].map!(l => l.to!int).array.sort.array;
	ulong total = countTotal(arr, 0);
	writeln(total);
}

ulong countTotal(int[] arr, int cur) {
	ulong total = 1;
	for (int i = 0; i + 1 < arr.length; i++) {
		if (arr[i + 1] - cur < 4) {
			total += memCountTotal(arr[i + 1..$], cur);
		}
		cur = arr[i];
	}
	return total;
}