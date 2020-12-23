import std.algorithm;
import std.stdio;

void main() {
	int[] arr = [7, 8, 4, 2, 3, 5, 9, 1, 6];
	for (int move = 0; move < 100; move++) {
		int[] hold = arr[1..4];
		arr = arr[0] ~ arr[4..$];
		int search = arr[0] - 1;
		int dest;
		while (true) {
			if (search < 0) {
				search = 9;
			}
			if (arr.canFind(search)) {
				dest = arr.countUntil(search) + 1;
				break;
			}
			search--;
		}
		arr = arr[0..dest] ~ hold ~ arr[dest..$];
		arr = arr[1..$] ~ arr[0];
	}
	writeln(arr);
}
