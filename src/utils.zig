const std = @import("std");

pub fn log(msg: []const u8) void {
    std.debug.print("{s}\n", .{msg});
}

pub fn Stack(comptime T: type) type {
    return struct {
        items: []T,
        capacity: usize,
        size: usize,

        pub fn init(allocator: *std.mem.Allocator, capacity: usize) !*Stack {
            var self = try allocator.create(Stack);
            self.capacity = capacity;
            self.size = 0;
            self.items = try allocator.alloc(T, capacity);
            return self;
        }

        pub fn deinit(self: *Stack, allocator: *std.mem.Allocator) void {
            allocator.free(self.items);
            allocator.destroy(self);
        }

        pub fn push(self: *Stack, item: T) !void {
            if (self.size >= self.capacity) {
                return error.StackOverflow;
            }
            self.items[self.size] = item;
            self.size += 1;
        }

        pub fn pop(self: *Stack) !T {
            if (self.size == 0) {
                return error.StackUnderflow;
            }
            self.size -= 1;
            return self.items[self.size];
        }

        pub fn isEmpty(self: *Stack) bool {
            return self.size == 0;
        }
    };
}
