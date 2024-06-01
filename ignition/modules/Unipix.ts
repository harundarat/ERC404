import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const owner = "0xB34a4eAECB848d573a0410bc305787d5B69328B8";
const dataURI = "ipfs://bafybeigoi2hhswr26veisptvfxk7xx3ni2ngg327fteb3oz5cupr6y2zoe/"

const UnipixModule = buildModule("UnipixModule", (m) => {

    const unipix = m.contract("Unipix", [owner, dataURI], {});

    return { unipix };

});

export default UnipixModule;