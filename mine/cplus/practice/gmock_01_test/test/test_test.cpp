#include "test.h"

#include <gtest/gtest.h>
#include <gmock/gmock.h>

class ClassTest : public ::testing::Test {
protected:
    virtual void SetUp() {} 
    virtual void TearDown() {}
    ClassTest() {}
    ~ClassTest() {}

protected:
    int mem_int;
};

class TestMyClass : public MyClass {
public:
    MOCK_METHOD2(foo, int(int, int));
};

TEST(ClassTest, normal) {
    {
    MyClass myclass;
    EXPECT_EQ(2, myclass.foo(4, 10));
    EXPECT_EQ(6, myclass.foo(30, 18));
    }
}

// 如果不指定，则返回默认的（返回值为整型的函数默认返回0，为布尔型的默认返回false，为指针的默认返回NULL）
TEST(ClassTest, mock) {
    {
    TestMyClass myclass;
    EXPECT_CALL(myclass, foo(testing::_, testing::_)).WillRepeatedly(testing::Return(100));
    //ON_CALL(myclass, foo(testing::_, testing::_)).WillByDefault(testing::Return(100));
    //EXPECT_CALL(myclass, foo(testing::_, testing::_)).Times(1).WillOnce(testing::Return(0));
    EXPECT_EQ(100, myclass.foo(4, 10));
    EXPECT_EQ(100, myclass.foo(30, 18));
    }
    {
    TestMyClass myclass;
    EXPECT_CALL(myclass, foo(testing::_, testing::_)).Times(2).WillOnce(testing::Return(200));
    EXPECT_EQ(200, myclass.foo(4, 10));
    EXPECT_EQ(0, myclass.foo(30, 18));
    }
}

TEST(ClassTest, mock2) {
    {
    TestMyClass myclass;
    //EXPECT_CALL(myclass, foo(testing::_, testing::_)).WillRepeatedly(testing::Return(0));
    EXPECT_EQ(0, myclass.foo(4, 10));
    EXPECT_EQ(0, myclass.foo(30, 18));
    }
}

int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
