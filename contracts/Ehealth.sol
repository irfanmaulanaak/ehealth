pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
// SPDX-License-Identifier: MIT

contract Ehealth{
    address manager;
    uint private idCounter;
    constructor () public {
        manager = msg.sender;
        idCounter = 0;
        addRumahSakit(0x8bD997ab0ABd89E9A23ff3cCCE5A71ddE6326f9A, "Rumah Sakit Wijaya Wiyung","123","Wiyung Surabaya");
    }
    
    struct Pasien {
        string nik;
        string nama;
        uint8 umur;
        string alamat;
        string gulaDarah;
        string tekananDarah;
        uint8 tb;
        uint8 bb;
        string[] informasi_penyakit;
    }
    
    struct Rumah_Sakit{
        address ethaddress;
        string nama;
        string idRS;
        string alamat;
    }
    Pasien[] private pasienList;
    Rumah_Sakit[] private rsList;
    
    function getManager() public view returns(address) {
        return manager;
    }
    
    //batas akhir fungsi dibawah untuk add informasi pasien & rumah sakit
    function addPasien(string memory _nik, string memory _nama, uint8 _umur, string memory _alamat) isRs public{
        Pasien memory newPasien =  Pasien({
           nik:_nik,
           nama: _nama,
           umur: _umur,
           alamat:_alamat,
           gulaDarah:'',
           tekananDarah:'',
           bb:0,
           tb:0,
           informasi_penyakit: new string[](0)
        });
        pasienList.push(newPasien);
    }
    
    function addRumahSakit(address _ethaddress, string memory _nama, string memory _idRS, string memory _alamat) isManager public {
        Rumah_Sakit memory newData = Rumah_Sakit({
           ethaddress: _ethaddress,
           nama: _nama,
           idRS: _idRS,
           alamat: _alamat
        });
        rsList.push(newData);
    }
    function addPenyakit (string memory _id, string memory _penyakit) isRs public {
        require(bytes(_penyakit).length > 0);
        for(uint i; i<pasienList.length;i++){
            if(keccak256(bytes(_id)) == keccak256(bytes(pasienList[i].nik))){
                pasienList[i].informasi_penyakit.push(_penyakit);
            }
        }
    }
    function addInfoKesehatan (string memory _id, string memory _gulaDarah, string memory _tekananDarah, uint8 _bb, uint8 _tb) isRs public {
        for(uint i; i<pasienList.length; i++){
            if(keccak256(bytes(_id)) == keccak256(bytes(pasienList[i].nik))){
                pasienList[i].gulaDarah=_gulaDarah;
                pasienList[i].tekananDarah=_tekananDarah;
                pasienList[i].bb=_bb;
                pasienList[i].tb=_tb;
            }else{
                revert("NIK Salah");
            }
        }
    }
    //batas akhir fungsi dibawah untuk add informasi pasien & rumah sakit
    
    //batas awal fungsi dibawah untuk get informasi pasien
    function getpasien_rs(string memory _nik) isRs public view returns(string memory, string memory, uint8, string memory, string memory, string memory, uint8, uint8, string[] memory){
        for(uint i; i<pasienList.length;i++){
            if(keccak256(bytes(_nik)) == keccak256(bytes(pasienList[i].nik))){
                return(pasienList[i].nik,pasienList[i].nama,pasienList[i].umur,pasienList[i].alamat,pasienList[i].gulaDarah,pasienList[i].tekananDarah,pasienList[i].bb,pasienList[i].tb,pasienList[i].informasi_penyakit);
            }
        }
    }
    function getpenyakit_rs(string memory _nik) isRs public view returns(string[] memory){
        string[] memory _info;
        for(uint i = 0;i<pasienList.length;i++){
            if(keccak256(bytes(_nik)) == keccak256(bytes(pasienList[i].nik))){
                _info = new string[](pasienList[i].informasi_penyakit.length);
                for(uint j = 0;j<pasienList[i].informasi_penyakit.length;j++){
                    _info[j] = pasienList[i].informasi_penyakit[j];
                }
            }else{
                revert("NIK salah");
            }
        }
        return(_info);
    }
    
    //batas awal untuk fungsi get info rumah sakit
    
    function getinfors(string memory _idRS) isManager public view returns(address, string memory, string memory, string memory){
        address _ethaddress;
        string memory _nama;
        string memory _alamat;
        
        for(uint i = 0; i<rsList.length;i++){
            if(keccak256(bytes(_idRS)) == keccak256(bytes(rsList[i].idRS))){
                _ethaddress = rsList[i].ethaddress;
                _nama = rsList[i].nama;
                _idRS = rsList[i].idRS;
                _alamat = rsList[i].alamat;
            }
        }
        return(_ethaddress, _nama, _idRS, _alamat);
    }
    
    
    function check_rs() public view returns(bool) {
        for(uint i = 0; i<rsList.length;i++){
            if(msg.sender == rsList[i].ethaddress){
                return true;
            }
        }
    }
    function check_manager() public view returns(bool) {
        if(manager == msg.sender){
            return true;
        }
    }

    modifier isManager(){
        require (manager == msg.sender);
        _;
    }
    modifier isRs(){
        require (check_rs());
        _;
    }
}
