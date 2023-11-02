#[starknet::interface]
trait ISimpleCounter<TContractState> {
    fn get_current_count(self: @TContractState) -> u256;
    fn jumpfront(ref self: TContractState);
    fn readjust(ref self: TContractState);
}


#[starknet::contract]
mod SimpleCounter {
    #[storage]
    struct Storage {
        // Counter variable
        counter: u256,
    }

    #[generate_trait]
    #[external(v0)]
    impl SimpleCounter of ISimpleCounter {
        fn get_current_count(self: @ContractState) -> u256 {
            return self.counter.read();
        }

        fn jumpfront(ref self: ContractState) {
            // Store counter value + 1
            let mut counter: u256 = self.counter.read() + 1;
            self.counter.write(counter);
        }
        fn readjust(ref self: ContractState) {
            // Store counter value - 1
            let mut counter: u256 = self.counter.read() - 1;
            self.counter.write(counter);
        }
    }
}
