pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
// SPDX-License-Identifier: MIT

contract Ehealth{
    address manager;
    uint private idCounter;
    constructor () public {
        manager = msg.sender;
        idCounter = 0;
    }
    
    struct Pasien {
        address ethaddress;
        uint nik;
        string nama;
        uint8 umur;
        string alamat;
        string[] informasi_penyakit;
    }
    
    struct Tenaga_Kesehatan{
        address ethaddress;
        string nama;
        uint8 umur;
        string alamat;
    }
    Pasien[] private pasienList;
    Tenaga_Kesehatan[] private tenKesList;
    
    function getManager() public view returns(address) {
        return manager;
    }
    
    //batas akhir fungsi dibawah untuk add informasi pasien & tenkes
    function addPasien(uint _nik, string memory _nama, uint8 _umur, string memory _alamat) public{
        Pasien memory newPasien =  Pasien({
           ethaddress: msg.sender,
           nik:_nik,
           nama: _nama,
           umur: _umur,
           alamat:_alamat,
           informasi_penyakit: new string[](0)
        });
        pasienList.push(newPasien);
    }
    
    function addTenkes(string memory _nama, uint8 _umur, string memory _alamat) public {
        Tenaga_Kesehatan memory newTenkes = Tenaga_Kesehatan({
           ethaddress: msg.sender,
           nama: _nama,
           umur: _umur,
           alamat: _alamat
        });
        tenKesList.push(newTenkes);
    }
    function addPenyakit (uint _id, string memory _penyakit) isTenkes public {
        require(bytes(_penyakit).length > 0);
        for(uint i; i<pasienList.length;i++){
            if(_id == pasienList[i].nik){
                pasienList[i].informasi_penyakit.push(_penyakit);
            }
        }
    }
    //batas akhir fungsi dibawah untuk add informasi pasien & tenkes
    
    //batas awal fungsi dibawah untuk get informasi pasien
    function getpasien_tenkes(uint _nik) isTenkes public view returns(uint, string memory, uint8, string memory){
        uint _id = 0;
        string memory _nama = '';
        uint8 _umur = 0;
        string memory _alamat = '';
        
        for(uint i = 0; i<pasienList.length;i++){
            if(_nik == pasienList[i].nik){
                _id = pasienList[i].nik;
                _nama = pasienList[i].nama;
                _umur = pasienList[i].umur;
                _alamat = pasienList[i].alamat;
            }
        }
        return(_id, _nama, _umur, _alamat);
    }
    function getpenyakit_tenkes(uint _nik) isTenkes public view returns(string[] memory){
        string[] memory _info;
        for(uint i = 0;i<pasienList.length;i++){
            if(_nik == pasienList[i].nik){
                _info = new string[](pasienList[i].informasi_penyakit.length);
                for(uint j = 0;j<pasienList[i].informasi_penyakit.length;j++){
                    _info[j] = pasienList[i].informasi_penyakit[j];
                }
            }
        }
        return(_info);
    }
    function getpasien_pasien() isPasien public view returns(uint, string memory, uint8, string memory){
        uint _id = 0;
        string memory _nama = '';
        uint8 _umur = 0;
        string memory _alamat = '';
        
        for(uint i = 0;i<pasienList.length;i++){
            if(msg.sender == pasienList[i].ethaddress){
                _id = pasienList[i].nik;
                _nama = pasienList[i].nama;
                _umur = pasienList[i].umur;
                _alamat = pasienList[i].alamat;
            }
        }
        return(_id,_nama, _umur,_alamat);
    }
    function getpenyakit_pasien() isPasien public view returns(string[] memory){
        string[] memory _info;
        for(uint i = 0;i<pasienList.length;i++){
            if(msg.sender == pasienList[i].ethaddress){
                _info = new string[](pasienList[i].informasi_penyakit.length);
                for(uint j = 0;j<pasienList[i].informasi_penyakit.length;j++){
                    _info[j] = pasienList[i].informasi_penyakit[j];
                }
            }
        }
        return(_info);
    }
    //batas akhir fungsi get info pasien
    
    function check_pasien() public view returns(bool){
        for(uint i = 0; i < pasienList.length;i++){
            if(msg.sender == pasienList[i].ethaddress){
                return true;
            }
        }
    }
    function check_tenkes() public view returns(bool) {
        for(uint i = 0; i<tenKesList.length;i++){
            if(msg.sender == tenKesList[i].ethaddress){
                return true;
            }
        }
    }

    modifier isManager(){
        require (manager == msg.sender);
        _;
    }
    modifier isTenkes(){
        require (check_tenkes());
        _;
    }
    modifier isPasien(){
        require(check_pasien());
        _;
    }
    modifier permissionData(){
        require(check_tenkes() || check_pasien());
        _;
    }
    
}
