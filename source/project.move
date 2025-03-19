module MyModule::DatingApp {
    use aptos_framework::signer;

    /// Struct representing a user profile.
    struct UserProfile has store, key {
        owner: address,  // Address of the user
        likes: vector<address>, // List of liked users
    }

    /// Function to register a user in the dating app.
    public fun register_user(user: &signer) {
        let owner = signer::address_of(user);
        let profile = UserProfile {
            owner,
            likes: vector::empty<address>(),
        };
        move_to(user, profile);
    }

    /// Function to like another user.
    public fun like_user(liker: &signer, liked_user: address) acquires UserProfile {
        let profile = borrow_global_mut<UserProfile>(signer::address_of(liker));
        vector::push_back(&mut profile.likes, liked_user);
    }
}
