module starrydesert_swap::sd_coin {
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::url::{Self, Url};

    public struct SD_COIN has drop {}

    fun init(
        witness: SD_COIN,
        ctx: &mut TxContext
    ) {
        let (treasury_cap, metadata) = coin::create_currency<SD_COIN>(
            witness,
            9,
            b"SD",
            b"SD_COIN",
            b"StarryDesert Coin",
            option::some<Url>(
                url::new_unsafe_from_bytes(
                    b"https://avatars.githubusercontent.com/u/86464159"
                )
            ),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(
            treasury_cap,
            tx_context::sender(ctx)
        )
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<SD_COIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }

    public fun burn(
        treasury_cap: &mut TreasuryCap<SD_COIN>,
        coin: Coin<SD_COIN>
    ) {
        coin::burn(treasury_cap, coin);
    }
}
