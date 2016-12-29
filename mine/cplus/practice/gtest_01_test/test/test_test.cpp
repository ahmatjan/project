#include "test.h"

#include <gtest/gtest.h>

class ClassTest : public ::testing::Test {
protected:
    virtual void SetUp() {} 
    virtual void TearDown() {}
    ClassTest() {}
    ~ClassTest() {}

protected:
    int mem_int;
};

TEST(fooTest, HandleNoneZeroInput) {
    EXPECT_EQ(2, foo(4, 10));
    EXPECT_EQ(6, foo(30, 18));
}

