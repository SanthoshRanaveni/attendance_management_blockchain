pragma solidity ^0.4.18;

contract Owned {
    address owner;
    
    function Owned() public {
        owner = msg.sender;
    }
    
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}

contract AttendanceSheet is Owned {
    
    struct Student {
        uint age;
        string fName;
        string lName;
        uint attendanceValue;
    }
    
    mapping (uint => Student) studentList;
    uint[] public studIdList;
    
    event studentCreationEvent(
       string fName,
       string lName,
       uint age
    );
    
    function createStudent(uint _studId, uint _age, string _fName, string _lName) onlyOwner public {
        var student = studentList[_studId];
        
        student.age = _age;
        student.fName = _fName;
        student.lName = _lName;
        student.attendanceValue = 0;
        studIdList.push(_studId) -1;
        studentCreationEvent(_fName, _lName, _age);
    }
    
    function incrementAttendance(uint _studId) onlyOwner public {
        studentList[_studId].attendanceValue = studentList[_studId].attendanceValue+1;
    }
    
    function getStudents() view public returns(uint[]) {
        return studIdList;
    }
    
    function getParticularStudent(uint _studId) public view returns (string, string, uint, uint) {
        return (studentList[_studId].fName, studentList[_studId].lName, studentList[_studId].age, studentList[_studId].attendanceValue);
    }

    function countStudents() view public returns (uint) {
        return studIdList.length;
    }
    
}
