import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

struct Queue(int SIZE) {
	int[SIZE] arr;
	int start = 0, end = 0;

	@property int length() {
		if (end < start) {
			return SIZE + end - start;
		}
		return end - start;
	}

	int pop() {
		int ret = arr[start];
		start++;
		if (start >= SIZE) {
			start = 0;
		}
		return ret;
	}

	void push(int[] inArr) {
		foreach (int i; inArr) {
			arr[end] = i;
			end++;
			if (end >= SIZE) {
				end = 0;
			}
		}
	}

	int[] slice() {
		if (end < start) {
			return arr[start..SIZE] ~ arr[0..end];
		}
		return arr[start..end];
	}
}

void main() {
	string input = cast(string) read("../input.txt");
	string[] players = input.split("\n\n");
	Queue!51 p1, p2;
	p1.push(players[0].split("\n")[1..$].map!(to!int).array);
	p2.push(players[1].split("\n")[1..$ - 1].map!(to!int).array);
	//p1.push([9, 2, 6, 3, 1]);
	//p2.push([5, 8, 4, 7, 10]);
	p1 = combat(p1, p2).queue;
	ulong mult = 1;
	ulong total;
	while (p1.length > 0) {
		int i = p1.pop();
		total += (p1.length + 1) * i;
	}
	writeln(total);
}

struct Ret {
	Queue!51 queue;
	bool p2Win;
}

struct Prev {
	int[] p1, p2;
}

Ret combat(Queue!51 p1, Queue!51 p2) {
	bool[Prev] previousHands;
	while (p1.length > 0 && p2.length > 0) {
		Prev r = Prev(p1.slice.dup, p2.slice.dup);
		if (r in previousHands) {
			return Ret(p1, false);
		}
		previousHands[r] = true;
		int c1 = p1.pop();
		int c2 = p2.pop();
		if (p1.length >= c1 && p2.length >= c2) {
			Queue!51 np1 = p1, np2 = p2;
			np1.end = np1.start + c1;
			if (np1.end >= 51) {
				np1.end -= 51;
			}
			np2.end = np2.start + c2;
			if (np2.end >= 51) {
				np2.end -= 51;
			}
			Ret ret = combat(np1, np2);
			if (ret.p2Win) {
				p2.push([c2, c1]);
			} else {
				p1.push([c1, c2]);
			}
		} else {
			if (c1 > c2) {
				p1.push([c1, c2]);
			} else {
				p2.push([c2, c1]);
			}
		}
	}
	Ret ret;
	ret.p2Win = false;
	if (p1.length == 0) {
		p1 = p2;
		ret.p2Win = true;
	}
	ret.queue = p1;
	return ret;
}
