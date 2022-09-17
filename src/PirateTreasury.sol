// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

//  ███▄    █  ▒█████       ██████  ██▓▓█████▄   ██████ ▓█████  ██▓         ▓█████▄▄▄█████▓ ██░ ██ 
//  ██ ▀█   █ ▒██▒  ██▒   ▒██    ▒ ▓██▒▒██▀ ██▌▒██    ▒ ▓█   ▀ ▓██▒         ▓█   ▀▓  ██▒ ▓▒▓██░ ██▒
// ▓██  ▀█ ██▒▒██░  ██▒   ░ ▓██▄   ▒██▒░██   █▌░ ▓██▄   ▒███   ▒██░         ▒███  ▒ ▓██░ ▒░▒██▀▀██░
// ▓██▒  ▐▌██▒▒██   ██░     ▒   ██▒░██░░▓█▄   ▌  ▒   ██▒▒▓█  ▄ ▒██░         ▒▓█  ▄░ ▓██▓ ░ ░▓█ ░██ 
// ▒██░   ▓██░░ ████▓▒░   ▒██████▒▒░██░░▒████▓ ▒██████▒▒░▒████▒░██████▒ ██▓ ░▒████▒ ▒██▒ ░ ░▓█▒░██▓
// ░ ▒░   ▒ ▒ ░ ▒░▒░▒░    ▒ ▒▓▒ ▒ ░░▓   ▒▒▓  ▒ ▒ ▒▓▒ ▒ ░░░ ▒░ ░░ ▒░▓  ░ ▒▓▒ ░░ ▒░ ░ ▒ ░░    ▒ ░░▒░▒
// ░ ░░   ░ ▒░  ░ ▒ ▒░    ░ ░▒  ░ ░ ▒ ░ ░ ▒  ▒ ░ ░▒  ░ ░ ░ ░  ░░ ░ ▒  ░ ░▒   ░ ░  ░   ░     ▒ ░▒░ ░
//    ░   ░ ░ ░ ░ ░ ▒     ░  ░  ░   ▒ ░ ░ ░  ░ ░  ░  ░     ░     ░ ░    ░      ░    ░       ░  ░░ ░
//          ░     ░ ░           ░   ░     ░          ░     ░  ░    ░  ░  ░     ░  ░         ░  ░  ░
//                                      ░                                ░                         
//                                        .xm*f""??T?@hc.
//                                      z@"` '~((!!!!!!!?*m.
//                                    z$$$K   ~~(/!!!!!!!!!Mh
//                                  .f` "#$k'`~~\!!!!!!!!!!!MMc
//                                 :"     f*! ~:~(!!!!!!!!!!XHMk
//                                 f      " %n:~(!!!!!!!!!!!HMMM.
//                                d          X~!~(!!!!!!!X!X!SMMR
//                                M :   x::  :~~!>!!!!!!MNWXMMM@R
//             n                  E ' *  ueeeeiu(!!XUWWWWWXMRHMMM>                :.
//             E%                 E  8 .$$$$$$$$K!!$$$$$$$$&M$RMM>               :"5
//            z  %                3  $ 4$$$$$$$$!~!*$$$$$$$$!$MM$               :" `
//            K   ":              ?> # '#$$$$$#~!!!!TR$$$$$R?@MME              z   R
//            ?     %.             5     ^"""~~~:XW!!!!T?T!XSMMM~            :^    J
//             ".    ^s             ?.       ~~d$X$NX!!!!!!M!MM             f     :~
//              '+.    #L            *c:.    .~"?!??!!!!!XX@M@~           z"    .*
//                '+     %L           #c`"!+~~~!/!!!!!!@*TM8M           z"    .~
//                  ":    '%.         'C*X  .!~!~!!!!!X!!!@RF         .#     +
//                    ":    ^%.        9-MX!X!!X~H!!M!N!X$MM        .#`    +"
//                      #:    "n       'L'!~M~)H!M!XX!$!XMXF      .+`   .z"
//                        #:    ":      R *H$@@$H$*@$@$@$%M~     z`    +"
//                          %:   `*L    'k' M!~M~X!!$!@H!tF    z"    z"
//                            *:   ^*L   "k ~~~!~!!!!!M!X*   z*   .+"
//                              "s   ^*L  '%:.~~~:!!!!XH"  z#   .*"
//                                #s   ^%L  ^"#4@UU@##"  z#   .*"
//                                  #s   ^%L           z#   .r"
//                                    #s   ^%.       u#   .r"
//                                      #i   '%.   u#   .@"
//                                        #s   ^%u#   .@"
//                                          #s x#   .*"
//                                           x#`  .@%.
//                                         x#`  .d"  "%.
//                                       xf~  .r" #s   "%.
//                                 u   x*`  .r"     #s   "%.  x.
//                                 %Mu*`  x*"         #m.  "%zX"
//                                 :R(h x*              "h..*dN.
//                               u@NM5e#>                 7?dMRMh.
//                             z$@M@$#"#"                 *""*@MM$hL
//                           u@@MM8*                          "*$M@Mh.
//                         z$RRM8F"                             "N8@M$bL
//                        5`RM$#                                  'R88f)R
//                        'h.$"                                     #$x*


import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract PirateTreasury {

    error Fuck();
    error Scallywag();

    event ChestBurried(uint256 coins);
    event FoundTreasure(uint256 coins);

    error NoMoneyForYa();
    
    uint256 public confiscatedCoins;

    /// Multisig vars
    mapping(bytes32 => address[]) internal multiSigChests;
    mapping(bytes32 => mapping(bytes32 => address)) internal multiSigChestLocations;
    mapping(bytes32 => uint256) internal multiSigChestTreasury;
    mapping(bytes32 => mapping(address => uint256)) internal multiSigChestTimers;

    // Some addresses are cursed for abandoning the crew (Sidsel.eth) (not pointing any fingers)
    // To see the full cursed list
    // https://shorturl.at/aerW0
    mapping (address => bool) private cursed;

    // address -> hash
    mapping(address => bytes32) public pirates;

    // hash -> chest 
    mapping(bytes32 => address) public chestKeuys;

    // hash -> amount buried in treasure
    mapping(bytes32 => uint256) private coins;

    constructor() {
        cursed[0x7447aa707b577D1EB65f8f7102fd3A54Ad81fa6d] = true; // <------------- Sidsel.eth
    }

    function coinsInChest(bytes32 chest) external returns(uint256) {
        return coins[chest];
    }   

    /// @notice Use thissss to burry yar chest somewhere
    /// @param chest - geolocation hash
    /// @param keuy - address that can sign message that unlocks
    function burryChest(bytes32 chest, address keuy) external payable {
        if (cursed[msg.sender]) {
            // take money yarrrrr'
            confiscatedCoins += msg.value;
        } else {
            pirates[msg.sender] = chest;
            chestKeuys[chest] = keuy;
            coins[chest] += msg.value;
            emit ChestBurried(msg.value);
        }
    }

    // TODO: we don't care about replay attacks, true pirate will kill whoever did it

    /// @notice If yer a pirate, use thissss to digg yer treasure chest
    /// @dev Don't spend it all in an inn and on whores
    /// @param chest - geolocation hash
    /// @param amount - amount of coins you want to recover from your chest
    /// @param treasure - chest signed by key
    function diggChest(bytes32 chest, uint256 amount, bytes calldata treasure) external {
        if (coins[chest] < amount) {
            revert NoMoneyForYa();
        }

        coins[chest] -= amount;

        if (pirates[msg.sender] == chest) {
            (bool v, bytes memory a) = msg.sender.call{value: amount}("");
            if(!v) {
                revert Fuck();
            }
            emit FoundTreasure(amount);
            return;
        }

        (address kuey, ECDSA.RecoverError err) = ECDSA.tryRecover(chest, treasure);
        if (chestKeuys[chest] != kuey) {
            revert NoMoneyForYa();
        }

        (bool v, bytes memory a) = msg.sender.call{value: amount}("");
        if(!v) {
            revert Fuck();
        }

        emit FoundTreasure(amount);
    }

        /// @notice Creates a new MultiSig chest
        /// @param  users array of addresses
        /// @param  locations where do the addresses need to be
        /// @param  chest the target code
        function createMultiSigChest(address[] memory users, bytes32[] memory locations, bytes32 chest) external payable {
            require(users.length == locations.length, "Array mismatch");
            multiSigChests[chest] = users;
            multiSigChestTreasury[chest] += msg.value;
            for (uint256 i; i < users.length; i++) {
                multiSigChestLocations[chest][locations[i]] = users[i];
            }
    }

    /// @notice Attempts to withdraw the treasure
    /// @param chest target chest
    /// @param location the location hash
    /// @return success success was the withdrawal successful
    function withdrawMultiSigChest(bytes32 chest, bytes32 location) external returns (bool success) {
        for (uint256 i; i < multiSigChests[chest].length; i++) {
            if (multiSigChests[chest][i] == msg.sender) {
                continue;
            } else {
                revert Scallywag();
            }
        }

        if (multiSigChestLocations[chest][location] != msg.sender) {
            revert Scallywag();
        } else {
            success = attemptUnite(chest);
        }
    }

    /// @notice Attempts to bring together the pieces of 8
    /// @param  chest the target chest
    /// @return flag were the pieces of 8 brought together
    function attemptUnite(bytes32 chest) internal returns (bool flag) {
        for (uint256 i; i < multiSigChests[chest].length; i++) {
            if (multiSigChestTimers[chest][multiSigChests[chest][i]] == 0) {
                multiSigChestTimers[chest][msg.sender] = block.timestamp;
                return false;
            }
        }
        if (_checkTime(chest) != true) {
            return false;
        }
        (bool success, ) = msg.sender.call{value: multiSigChestTreasury[chest]}("");
        delete multiSigChestTreasury[chest];
        return success;
    }

    function _checkTime(bytes32 chest) internal view returns (bool) {
        uint256 latestTime;
        for (uint256 i; i < multiSigChests[chest].length; i++) {
            if (latestTime < multiSigChestTimers[chest][multiSigChests[chest][i]]) {
                if (multiSigChestTimers[chest][multiSigChests[chest][i]] > (latestTime + 5 minutes)) {
                    return false;
                }
                latestTime = multiSigChestTimers[chest][multiSigChests[chest][i]];
            }
        }
        return true;
    }
}